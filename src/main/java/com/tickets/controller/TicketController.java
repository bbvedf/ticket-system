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
    
    @GetMapping
    public String listTickets(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String priority,
            @RequestParam(required = false) String search,
            Model model) {
        
        List<Ticket> tickets = ticketService.findAllFiltered(status, priority, search);
        model.addAttribute("tickets", tickets);
        return "tickets";
    }
    
    @GetMapping("/{id}")
    public String viewTicket(@PathVariable Long id, Model model) {
        Ticket ticket = ticketService.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket no encontrado"));
        model.addAttribute("ticket", ticket);
        return "ticket-detail";
    }
    
    @GetMapping("/new")
    public String newTicketForm(Model model) {
        model.addAttribute("ticket", new Ticket());
        return "ticket-form";
    }
    
    @PostMapping
    public String createTicket(@ModelAttribute Ticket ticket) {
        ticketService.save(ticket);
        return "redirect:/tickets?message=Ticket creado exitosamente";
    }
}