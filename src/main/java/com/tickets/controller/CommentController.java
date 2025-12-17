// src/main/java/com/tickets/controller/CommentController.java
package com.tickets.controller;

import com.tickets.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tickets/{ticketId}/comments")
@RequiredArgsConstructor
public class CommentController {
    
    private final CommentService commentService;
    
    @PostMapping
    public String addComment(@PathVariable Long ticketId,
                            @RequestParam String authorName,
                            @RequestParam String commentText) {
        commentService.addComment(ticketId, authorName, commentText);
        return "redirect:/tickets/" + ticketId + "?message=Comentario añadido";
    }
    
    @GetMapping("/{commentId}/delete")
    public String deleteComment(@PathVariable Long ticketId,
                               @PathVariable Long commentId) {
        commentService.deleteComment(commentId);
        return "redirect:/tickets/" + ticketId + "?message=Comentario eliminado";
    }
}