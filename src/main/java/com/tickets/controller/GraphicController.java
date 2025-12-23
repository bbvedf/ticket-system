package com.tickets.controller;

import com.tickets.service.GraphicService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/graficos")
@RequiredArgsConstructor
public class GraphicController {
    
    private final GraphicService graphicService;
    
    @GetMapping
    public String viewGraphics(Model model) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        
        model.addAttribute("ticketsByStatusJson", mapper.writeValueAsString(graphicService.getTicketsByStatus()));
        model.addAttribute("ticketsByPriorityJson", mapper.writeValueAsString(graphicService.getTicketsByPriority()));
        model.addAttribute("assignedVsUnassignedJson", mapper.writeValueAsString(graphicService.getAssignedVsUnassigned()));
        model.addAttribute("ticketsByCategoryJson", mapper.writeValueAsString(graphicService.getTicketsByCategory()));
        model.addAttribute("resolutionRate", graphicService.getResolutionRate());
        model.addAttribute("avgTimeByPriorityJson", mapper.writeValueAsString(graphicService.getAvgTimeByPriority()));
        model.addAttribute("statusDistributionJson", mapper.writeValueAsString(graphicService.getStatusDistribution()));
        model.addAttribute("temporalEvolutionJson", mapper.writeValueAsString(graphicService.getTemporalEvolution()));
        
        return "graphic";
        }
}