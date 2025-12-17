// src/main/java/com/tickets/service/CommentService.java
package com.tickets.service;

import com.tickets.model.Comment;
import com.tickets.model.Ticket;
import com.tickets.repository.CommentRepository;
import com.tickets.repository.TicketRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class CommentService {
    
    private final CommentRepository commentRepository;
    private final TicketRepository ticketRepository;
    
    public List<Comment> findByTicketId(Long ticketId) {
        return commentRepository.findByTicketIdOrderByCreatedAtAsc(ticketId);
    }
    
    public Comment addComment(Long ticketId, String authorName, String commentText) {
        Ticket ticket = ticketRepository.findById(ticketId)
                .orElseThrow(() -> new RuntimeException("Ticket no encontrado"));
        
        Comment comment = new Comment();
        comment.setTicket(ticket);
        comment.setAuthorName(authorName);
        comment.setCommentText(commentText);
        
        return commentRepository.save(comment);
    }
    
    public void deleteComment(Long commentId) {
        commentRepository.deleteById(commentId);
    }
}