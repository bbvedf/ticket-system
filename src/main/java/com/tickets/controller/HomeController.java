// src/main/java/com/tickets/controller/HomeController.java
package com.tickets.controller;

import com.tickets.service.TicketService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class HomeController {
    
    private final TicketService ticketService;
    
    // HOME PAGE - renderiza JSP
    @GetMapping("/")
    public String home(Model model) {
        long totalTickets = ticketService.findAll().size();
        long openTickets = ticketService.countByStatus("OPEN");
        long inProgressTickets = ticketService.countByStatus("IN_PROGRESS");
        long resolvedTickets = ticketService.countByStatus("RESOLVED");
        
        model.addAttribute("totalTickets", totalTickets);
        model.addAttribute("openTickets", openTickets);
        model.addAttribute("inProgressTickets", inProgressTickets);
        model.addAttribute("resolvedTickets", resolvedTickets);
        
        return "home";
    }
}