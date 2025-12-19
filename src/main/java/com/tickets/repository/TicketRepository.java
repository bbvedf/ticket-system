package com.tickets.repository;

import com.tickets.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    // Consultas básicas de Spring Data
    java.util.List<Ticket> findAllByOrderByCreatedAtDesc();

    long countByStatus(String status);
    long countByStatusAndPriority(String status, String priority);
    Page<Ticket> findAll(Pageable pageable);
    Page<Ticket> findAllByOrderByCreatedAtDesc(Pageable pageable);
}
