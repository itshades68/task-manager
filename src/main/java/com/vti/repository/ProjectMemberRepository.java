package com.vti.repository;

import com.vti.model.Project;
import com.vti.model.ProjectMember;
import com.vti.model.ProjectMemberId;

import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProjectMemberRepository extends JpaRepository<ProjectMember, ProjectMemberId> {
    List<ProjectMember> findByProjectId(Integer projectId);
    List<ProjectMember> findByUserId(Integer userId);
    boolean existsByProjectIdAndUserId(Integer projectId, Integer userId);
    @Modifying
    @Transactional
    @Query("DELETE FROM ProjectMember pm WHERE pm.id.projectId = :projectId")
    void deleteByProjectId(@Param("projectId") Integer projectId);
}