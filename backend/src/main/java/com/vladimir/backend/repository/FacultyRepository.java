package com.vladimir.backend.repository;

import com.vladimir.backend.model.Faculty;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface FacultyRepository extends JpaRepository<Faculty, UUID> {

}
