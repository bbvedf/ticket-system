package com.tickets.service;

import com.tickets.model.Ticket;
import com.tickets.repository.TicketRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@RequiredArgsConstructor
public class GraphicService {
    
    private final TicketRepository ticketRepository;
    
    // 1. Tickets por estado
    public Map<String, Object> getTicketsByStatus() {
        List<Ticket> allTickets = ticketRepository.findAll();
        Map<String, Long> counts = new HashMap<>();
        
        counts.put("OPEN", allTickets.stream().filter(t -> "OPEN".equals(t.getStatus())).count());
        counts.put("IN_PROGRESS", allTickets.stream().filter(t -> "IN_PROGRESS".equals(t.getStatus())).count());
        counts.put("RESOLVED", allTickets.stream().filter(t -> "RESOLVED".equals(t.getStatus())).count());
        counts.put("CLOSED", allTickets.stream().filter(t -> "CLOSED".equals(t.getStatus())).count());
        
        return Map.of(
            "labels", List.of("Abierto", "En Progreso", "Resuelto", "Cerrado"),
            "data", List.of(counts.get("OPEN"), counts.get("IN_PROGRESS"), counts.get("RESOLVED"), counts.get("CLOSED"))
        );
    }
    
    // 2. Tickets por prioridad
    public Map<String, Object> getTicketsByPriority() {
        List<Ticket> allTickets = ticketRepository.findAll();
        Map<String, Long> counts = new HashMap<>();
        
        counts.put("LOW", allTickets.stream().filter(t -> "LOW".equals(t.getPriority())).count());
        counts.put("MEDIUM", allTickets.stream().filter(t -> "MEDIUM".equals(t.getPriority())).count());
        counts.put("HIGH", allTickets.stream().filter(t -> "HIGH".equals(t.getPriority())).count());
        counts.put("CRITICAL", allTickets.stream().filter(t -> "CRITICAL".equals(t.getPriority())).count());
        
        return Map.of(
            "labels", List.of("Baja", "Media", "Alta", "Crítica"),
            "data", List.of(counts.get("LOW"), counts.get("MEDIUM"), counts.get("HIGH"), counts.get("CRITICAL"))
        );
    }
    
    // 3. Asignado vs sin asignar
    public Map<String, Object> getAssignedVsUnassigned() {
        List<Ticket> allTickets = ticketRepository.findAll();
        long assigned = allTickets.stream().filter(t -> t.getAssignedTo() != null && !t.getAssignedTo().isEmpty()).count();
        long unassigned = allTickets.size() - assigned;
        
        return Map.of(
            "labels", List.of("Asignados", "Sin asignar"),
            "data", List.of(assigned, unassigned)
        );
    }
    
    // 4. Tickets por categoría
    public Map<String, Object> getTicketsByCategory() {
        List<Ticket> allTickets = ticketRepository.findAll();
        Map<String, Long> counts = allTickets.stream()
            .filter(t -> t.getCategory() != null && !t.getCategory().isEmpty())
            .collect(Collectors.groupingBy(Ticket::getCategory, Collectors.counting()));
        
        // Top 10 categorías
        Map<String, Long> topCategories = counts.entrySet().stream()
            .sorted((a, b) -> Long.compare(b.getValue(), a.getValue()))
            .limit(10)
            .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
        
        return Map.of(
            "labels", new ArrayList<>(topCategories.keySet()),
            "data", new ArrayList<>(topCategories.values())
        );
    }
    
    // 5. Tasa de resolución (%)
    public Map<String, Object> getResolutionRate() {
        List<Ticket> allTickets = ticketRepository.findAll();
        long total = allTickets.size();
        long resolved = allTickets.stream()
            .filter(t -> "RESOLVED".equals(t.getStatus()) || "CLOSED".equals(t.getStatus()))
            .count();
        
        double rate = total > 0 ? (resolved * 100.0 / total) : 0;
        
        return Map.of(
            "resolved", resolved,
            "total", total,
            "rate", String.format("%.1f", rate)
        );
    }
    
    // 6. Tiempo promedio de resolución por prioridad
    public Map<String, Object> getAvgTimeByPriority() {
        List<Ticket> allTickets = ticketRepository.findAll();
        Map<String, List<Long>> timesByPriority = new HashMap<>();
        
        for (String priority : List.of("LOW", "MEDIUM", "HIGH", "CRITICAL")) {
            List<Long> times = allTickets.stream()
                .filter(t -> priority.equals(t.getPriority()) && 
                           ("RESOLVED".equals(t.getStatus()) || "CLOSED".equals(t.getStatus())))
                .map(t -> {
                    if (t.getResolvedAt() != null && t.getCreatedAt() != null) {
                        return ChronoUnit.HOURS.between(t.getCreatedAt(), t.getResolvedAt());
                    }
                    return 0L;
                })
                .collect(Collectors.toList());
            
            double avg = times.isEmpty() ? 0 : times.stream().mapToLong(Long::longValue).average().orElse(0);
            timesByPriority.put(priority, List.of((long) avg));
        }
        
        return Map.of(
            "labels", List.of("Baja", "Media", "Alta", "Crítica"),
            "data", List.of(
                timesByPriority.get("LOW").get(0),
                timesByPriority.get("MEDIUM").get(0),
                timesByPriority.get("HIGH").get(0),
                timesByPriority.get("CRITICAL").get(0)
            )
        );
    }
    
    // 7. Distribución estado en tiempo real
    public Map<String, Object> getStatusDistribution() {
        return getTicketsByStatus(); // Mismo que #1 pero presentado diferente
    }
    
    // 8. Evolución temporal (últimos 7 días)
    public Map<String, Object> getTemporalEvolution() {
        List<Ticket> allTickets = ticketRepository.findAll();
        Map<String, Long> dailyCounts = new LinkedHashMap<>();
        
        for (int i = 6; i >= 0; i--) {
            LocalDateTime date = LocalDateTime.now().minusDays(i);
            String dateStr = date.toLocalDate().toString();
            long count = allTickets.stream()
                .filter(t -> t.getCreatedAt() != null && 
                           t.getCreatedAt().toLocalDate().equals(date.toLocalDate()))
                .count();
            dailyCounts.put(dateStr, count);
        }
        
        return Map.of(
            "labels", new ArrayList<>(dailyCounts.keySet()),
            "data", new ArrayList<>(dailyCounts.values())
        );
    }
}