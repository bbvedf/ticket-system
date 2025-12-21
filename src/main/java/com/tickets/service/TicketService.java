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
        long lowOpen = ticketRepository.countByStatusAndPriority("OPEN", "LOW");
        long lowInProgress = ticketRepository.countByStatusAndPriority("IN_PROGRESS", "LOW");
        
        long mediumOpen = ticketRepository.countByStatusAndPriority("OPEN", "MEDIUM");
        long mediumInProgress = ticketRepository.countByStatusAndPriority("IN_PROGRESS", "MEDIUM");
        
        long highOpen = ticketRepository.countByStatusAndPriority("OPEN", "HIGH");
        long highInProgress = ticketRepository.countByStatusAndPriority("IN_PROGRESS", "HIGH");
        
        long criticalOpen = ticketRepository.countByStatusAndPriority("OPEN", "CRITICAL");
        long criticalInProgress = ticketRepository.countByStatusAndPriority("IN_PROGRESS", "CRITICAL");
        
        counts.put("LOW", lowOpen + lowInProgress);
        counts.put("MEDIUM", mediumOpen + mediumInProgress);
        counts.put("HIGH", highOpen + highInProgress);
        counts.put("CRITICAL", criticalOpen + criticalInProgress);
        return counts;
    }

    public Page<Ticket> findAllPaginated(int page, int size, String status, String priority, String search) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        return ticketRepository.findByFilters(status, priority, search, pageable);
    }

    @Transactional
    public void updateTicket(Long id, Ticket ticketData) {
        Ticket existing = findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket no encontrado"));
        
        if (ticketData.getTitle() != null) existing.setTitle(ticketData.getTitle());
        if (ticketData.getDescription() != null) existing.setDescription(ticketData.getDescription());
        if (ticketData.getStatus() != null) existing.setStatus(ticketData.getStatus());
        if (ticketData.getPriority() != null) existing.setPriority(ticketData.getPriority());
        if (ticketData.getCategory() != null) existing.setCategory(ticketData.getCategory());
        if (ticketData.getClientName() != null) existing.setClientName(ticketData.getClientName());
        if (ticketData.getClientEmail() != null) existing.setClientEmail(ticketData.getClientEmail());
        if (ticketData.getAssignedTo() != null) existing.setAssignedTo(ticketData.getAssignedTo());
        
        save(existing);
    }


}