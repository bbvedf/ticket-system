// src/main/java/com/tickets/controller/TicketController.java
package com.tickets.controller;

import com.tickets.model.Ticket;
import com.tickets.service.TicketService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/tickets")
@RequiredArgsConstructor
public class TicketController {
    
    private final TicketService ticketService;
    
    // Lista de tickets con filtros
    @GetMapping
    public String listTickets(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String priority,
            @RequestParam(required = false) String search,
            Model model) {
        
        List<Ticket> tickets = ticketService.findAllFiltered(
            emptyToNull(status),
            emptyToNull(priority),
            emptyToNull(search)
        );
        model.addAttribute("tickets", tickets);        
        model.addAttribute("openCount", ticketService.countByStatus("OPEN"));
        model.addAttribute("inProgressCount", ticketService.countByStatus("IN_PROGRESS"));
        model.addAttribute("resolvedCount", ticketService.countByStatus("RESOLVED"));
        model.addAttribute("totalCount", ticketService.countAll());
        return "tickets";
    }

    private String emptyToNull(String value) {
        return (value != null && value.isEmpty()) ? null : value;
    }
    
    // Ver detalle de un ticket
    @GetMapping("/{id}")
    public String viewTicket(@PathVariable Long id, Model model) {
        Ticket ticket = ticketService.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket no encontrado"));
        model.addAttribute("ticket", ticket);
        return "ticket-detail";
    }
    
    // Formulario nuevo ticket
    @GetMapping("/new")
    public String newTicketForm(Model model) {
        model.addAttribute("ticket", new Ticket());
        return "ticket-form";
    }
    
    // Crear nuevo ticket
    @PostMapping
    public String createTicket(@ModelAttribute Ticket ticket) {
        ticketService.save(ticket);
        return "redirect:/tickets?message=Ticket creado exitosamente";
    }
    
    // Formulario editar ticket
    @GetMapping("/{id}/edit")
    public String editTicketForm(@PathVariable Long id, Model model) {
        Ticket ticket = ticketService.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket no encontrado"));
        model.addAttribute("ticket", ticket);
        return "ticket-form";
    }
    
    // Actualizar ticket
    @PostMapping("/{id}")
    public String updateTicket(@PathVariable Long id, @ModelAttribute Ticket ticket) {
        Ticket existing = ticketService.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket no encontrado"));
        
        existing.setTitle(ticket.getTitle());
        existing.setDescription(ticket.getDescription());
        existing.setStatus(ticket.getStatus());
        existing.setPriority(ticket.getPriority());
        existing.setCategory(ticket.getCategory());
        existing.setClientName(ticket.getClientName());
        existing.setClientEmail(ticket.getClientEmail());
        existing.setAssignedTo(ticket.getAssignedTo());
        
        ticketService.save(existing);
        return "redirect:/tickets/" + id + "?message=Ticket actualizado";
    }
    
    // Eliminar ticket
    @GetMapping("/{id}/delete")
    public String deleteTicket(@PathVariable Long id) {
        ticketService.deleteById(id);
        return "redirect:/tickets?message=Ticket eliminado";
    }
    
    // Cambiar estado
    @GetMapping("/{id}/status")
    public String updateStatus(@PathVariable Long id, @RequestParam String status) {
        ticketService.updateStatus(id, status);
        return "redirect:/tickets/" + id + "?message=Estado actualizado";
    }
}