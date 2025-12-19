package com.tickets.service;

import com.tickets.model.Ticket;
import com.tickets.repository.TicketRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Map;
import java.util.HashMap;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;


@Service
@RequiredArgsConstructor
@Transactional
public class TicketService {
    
    private final TicketRepository ticketRepository;
    
    public List<Ticket> findAll() {
        return ticketRepository.findAllByOrderByCreatedAtDesc();
    }
    
    public List<Ticket> findAllFiltered(String status, String priority, String search) {
        List<Ticket> allTickets = findAll();
        
        return allTickets.stream()
                .filter(t -> status == null || t.getStatus().equals(status))
                .filter(t -> priority == null || t.getPriority().equals(priority))
                .filter(t -> search == null || 
                    t.getTitle().toLowerCase().contains(search.toLowerCase()) ||
                    t.getDescription().toLowerCase().contains(search.toLowerCase()) ||
                    (t.getClientName() != null && 
                    t.getClientName().toLowerCase().contains(search.toLowerCase())))
                .collect(Collectors.toList());
    }
    
    public Optional<Ticket> findById(Long id) {
        return ticketRepository.findById(id);
    }
    
    public Ticket save(Ticket ticket) {
        return ticketRepository.save(ticket);
    }
    
    public void deleteById(Long id) {
        ticketRepository.deleteById(id);
    }
    
    public Ticket updateStatus(Long id, String newStatus) {
        Ticket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket no encontrado"));
        ticket.setStatus(newStatus);
        return ticketRepository.save(ticket);
    }
    
    public long countByStatus(String status) {
        return ticketRepository.countByStatus(status);
    }

    public long countAll() {
        return ticketRepository.count();
    }

    public Map<String, Long> countOpenTicketsByPriority() {
    Map<String, Long> counts = new HashMap<>();
    counts.put("LOW", ticketRepository.countByStatusAndPriority("OPEN", "LOW"));
    counts.put("MEDIUM", ticketRepository.countByStatusAndPriority("OPEN", "MEDIUM"));
    counts.put("HIGH", ticketRepository.countByStatusAndPriority("OPEN", "HIGH"));
    counts.put("CRITICAL", ticketRepository.countByStatusAndPriority("OPEN", "CRITICAL"));
    return counts;
    }

    public Page<Ticket> findAllPaginated(int page, int size) {
    Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
    return ticketRepository.findAll(pageable);
    }

}