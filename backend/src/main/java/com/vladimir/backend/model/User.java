package com.vladimir.backend.model;

import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;


import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(generator = "UUID")
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "username", unique = true)
    private String username;

    @ManyToOne
    @JoinColumn(name = "department_id", nullable = false)
    private Department departmentId;

    @ManyToOne
    @JoinColumn(name = "faculty_id", nullable = false)
    private Faculty facultyId;

    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role roleId;

    public User(){

    }
    public User(String name, String email, String passwordHash,LocalDateTime createdAt,  String username, Department departmentId, Faculty facultyId, Role roleId) {
        this.name = name;
        this.email = email;
        this.passwordHash = passwordHash;
        this.username = username;
        this.createdAt = createdAt;
        this.departmentId = departmentId;
        this.facultyId = facultyId;
        this.roleId = roleId;
    }

    public UUID getId() {
        return id;
    }
    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public Department getDepartmentId() {
        return departmentId;
    }
    public void setDepartmentId(Department departmentId) {
        this.departmentId = departmentId;
    }

    public Faculty getFacultyId() {
        return facultyId;
    }
    public void setFacultyId(Faculty facultyId) {
        this.facultyId = facultyId;
    }

    public Role getRoleId() {
        return roleId;
    }
    public void setRoleId(Role roleId) {
        this.roleId = roleId;
    }


}

