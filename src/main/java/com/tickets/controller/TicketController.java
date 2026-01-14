// src/main/java/com/tickets/controller/TicketController.java
package com.tickets.controller;

import com.tickets.model.Ticket;
import com.tickets.service.TicketService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.Page;
import java.util.List;

@Controller
@RequestMapping("")
@RequiredArgsConstructor
public class TicketController {
    
    private final TicketService ticketService;
    
    // Lista de tickets con filtros
    @GetMapping("/all")
    public String listTickets(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String priority,
            @RequestParam(required = false) String search,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        
        // Pasar los filtros al servicio
        Page<Ticket> ticketPage = ticketService.findAllPaginated(
            page, size, 
            emptyToNull(status), 
            emptyToNull(priority), 
            search != null ? "%" + search.toLowerCase() + "%" : null
        );
        
        List<Ticket> tickets = ticketPage.getContent();
        
        model.addAttribute("tickets", tickets);
        model.addAttribute("openCount", ticketService.countByStatus("OPEN"));
        model.addAttribute("inProgressCount", ticketService.countByStatus("IN_PROGRESS"));
        model.addAttribute("resolvedAndClosedCount", 
            ticketService.countByStatus("RESOLVED") + ticketService.countByStatus("CLOSED"));
        model.addAttribute("totalCount", ticketService.countAll());
        model.addAttribute("openByPriority", ticketService.countOpenTicketsByPriority());

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", ticketPage.getTotalPages());
        model.addAttribute("totalItems", ticketPage.getTotalElements());
        model.addAttribute("pageSize", size);

        return "tickets";
    }

    private String emptyToNull(String value) {
        return (value != null && value.isEmpty()) ? null : value;
    }
    
    // Ver detalle de un ticket
    @GetMapping("/{id:[0-9]+}")
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
        return "redirect:/all?message=Ticket creado exitosamente";
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
    @PostMapping("/{id:[0-9]+}")
    public String updateTicket(@PathVariable Long id, @ModelAttribute Ticket ticket) {
        System.out.println("DEBUG: Ticket recibido: " + ticket);
        System.out.println("DEBUG: ID: " + ticket.getId());
        System.out.println("DEBUG: Title: " + ticket.getTitle());
        System.out.println("DEBUG: Priority: " + ticket.getPriority());
        System.out.println("DEBUG: Status: " + ticket.getStatus());
    
        ticketService.updateTicket(id, ticket);
        return "redirect:/all/" + id + "?message=Ticket actualizado";
    }
    
    // Eliminar ticket
    @GetMapping("/{id}/delete")
    public String deleteTicket(@PathVariable Long id) {
        ticketService.deleteById(id);
        return "redirect:/all?message=Ticket eliminado";
    }
    
    // Cambiar estado
    @GetMapping("/{id}/status")
    public String updateStatus(@PathVariable Long id, @RequestParam String status) {
        ticketService.updateStatus(id, status);
        return "redirect:/all/" + id + "?message=Estado actualizado";
    }
}