package com.vti.controller;

import com.vti.model.ProjectMember;
import com.vti.service.ProjectMemberService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/project-members")
public class ProjectMemberController {

    private final ProjectMemberService projectMemberService;

    public ProjectMemberController(ProjectMemberService projectMemberService) {
        this.projectMemberService = projectMemberService;
    }

    //ADMIN thêm member vào project
    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/add")
    public ResponseEntity<?> addMember(@RequestBody Map<String, Object> body) {
        Integer projectId = (Integer) body.get("projectId");
        Integer userId = (Integer) body.get("userId");

        if (projectId == null || userId == null) {
            return ResponseEntity.badRequest().body("projectId và userId không được để trống");
        }

        ProjectMember member = projectMemberService.addMember(projectId, userId);
        return ResponseEntity.ok(member);
    }

    //ADMIN xoá member khỏi project
    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/remove")
    public ResponseEntity<?> removeMember(@RequestBody Map<String, Object> body) {
        Integer projectId = (Integer) body.get("projectId");
        Integer userId = (Integer) body.get("userId");

        if (projectId == null || userId == null) {
            return ResponseEntity.badRequest().body("projectId và userId không được để trống");
        }

        projectMemberService.removeMember(projectId, userId);
        return ResponseEntity.noContent().build();
    }

    //ADMIN và USER xem danh sách thành viên của 1 project
    @PreAuthorize("hasAnyRole('ADMIN', 'USER')")
    @GetMapping("/project/{projectId}")
    public ResponseEntity<List<ProjectMember>> getMembersByProject(@PathVariable Integer projectId) {
        return ResponseEntity.ok(projectMemberService.getMembersByProject(projectId));
    }

    //ADMIN và USER xem danh sách các project mình tham gia
    @PreAuthorize("hasAnyRole('ADMIN', 'USER')")
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<ProjectMember>> getProjectsByUser(@PathVariable Integer userId) {
        return ResponseEntity.ok(projectMemberService.getProjectsByUser(userId));
    }
}
