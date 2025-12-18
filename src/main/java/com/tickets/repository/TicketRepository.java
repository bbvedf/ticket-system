package com.tickets.repository;

import com.tickets.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    // Consultas básicas de Spring Data
    java.util.List<Ticket> findAllByOrderByCreatedAtDesc();

    long countByStatus(String status);
}
