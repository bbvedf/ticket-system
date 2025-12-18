package com.tickets.service;

import com.tickets.model.Ticket;
import com.tickets.repository.TicketRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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
        return findAll().stream()
                .filter(t -> t.getStatus().equals(status))
                .count();
    }
}
