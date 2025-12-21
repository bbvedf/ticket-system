package com.tickets.repository;

import com.tickets.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    // Consultas básicas de Spring Data
    //Las consultas SQL/JPQL están en el repositorio, solo que Spring Data las genera automáticamente con los nombres de los métodos.
    java.util.List<Ticket> findAllByOrderByCreatedAtDesc();

    long countByStatus(String status); //SELECT COUNT(*) FROM ticket WHERE status = ?
    long countByStatusAndPriority(String status, String priority); //SELECT COUNT(*) FROM ticket WHERE status = ? AND priority = ?
    Page<Ticket> findAll(Pageable pageable); //SELECT * FROM ticket with pagination
    Page<Ticket> findAllByOrderByCreatedAtDesc(Pageable pageable); //SELECT * FROM ticket ORDER BY createdAt DESC with pagination

    @Query("SELECT t FROM Ticket t WHERE " +
        "(:status IS NULL OR t.status = :status) AND " +
        "(:priority IS NULL OR t.priority = :priority) AND " +
        "(:search IS NULL OR " +
        "LOWER(CAST(t.title AS string)) LIKE LOWER(CAST(:search AS string)) OR " +
        "LOWER(CAST(t.description AS string)) LIKE LOWER(CAST(:search AS string)) OR " +
        "LOWER(CAST(t.clientName AS string)) LIKE LOWER(CAST(:search AS string)) OR " +
        "LOWER(CAST(t.clientEmail AS string)) LIKE LOWER(CAST(:search AS string)))")
    Page<Ticket> findByFilters(@Param("status") String status, 
                                @Param("priority") String priority, 
                                @Param("search") String search, 
                                Pageable pageable);
}
