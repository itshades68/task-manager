package com.vti.controller;

import com.vti.model.Project;
import com.vti.model.Task;
import com.vti.model.User;
import com.vti.repository.ProjectRepository;
import com.vti.repository.UserRepository;
import com.vti.service.ProjectMemberService;
import com.vti.service.TaskService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/tasks")
public class TaskController {
    private final TaskService taskService;
    private final UserRepository userRepository;
    private final ProjectRepository projectRepository;
    private final ProjectMemberService projectMemberService;

    public TaskController(TaskService taskService,
                          UserRepository userRepository,
                          ProjectRepository projectRepository,
                          ProjectMemberService projectMemberService) {
        this.taskService = taskService;
        this.userRepository = userRepository;
        this.projectRepository = projectRepository;
        this.projectMemberService = projectMemberService;
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public ResponseEntity<Task> create(@RequestBody Map<String, Object> request) {
        Task task = parseTaskFromRequest(request);
        return ResponseEntity.ok(taskService.createTask(task));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PutMapping("/{id}")
    public ResponseEntity<Task> update(@PathVariable Integer id, @RequestBody Map<String, Object> request) {
        Task task = parseTaskFromRequest(request);
        return ResponseEntity.ok(taskService.updateTask(id, task));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        taskService.deleteTask(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/project/{projectId}")
    public ResponseEntity<List<Task>> getByProject(@PathVariable Integer projectId, Principal principal) {
        User user = userRepository.findByUsername(principal.getName()).orElseThrow();

        // Nếu không phải admin thì chỉ xem được task trong project mình tham gia
        if (!user.getRole().equals(User.Role.ADMIN)) {
            boolean isInProject = projectMemberService.isUserInProject(projectId, user.getId());
            if (!isInProject) {
                return ResponseEntity.status(403).build();
            }
        }

        return ResponseEntity.ok(taskService.getTasksByProject(projectId));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<Task> updateStatus(@PathVariable Integer id,
                                             @RequestBody Task request,
                                             Principal principal) {
        return ResponseEntity.ok(taskService.updateStatus(id, request.getStatus(), principal.getName()));
    }

    private Task parseTaskFromRequest(Map<String, Object> request) {
        String name = (String) request.get("name");
        String description = (String) request.get("description");
        String status = (String) request.get("status");
        String deadlineStr = (String) request.get("deadline");

        Integer projectId = (Integer) request.get("project");
        List<Integer> assignedUserIds = (List<Integer>) request.get("assignedUsers");

        Project project = projectRepository.findById(projectId).orElseThrow();
        Set<User> assignedUsers = assignedUserIds.stream()
                .map(id -> userRepository.findById(id).orElseThrow())
                .collect(java.util.stream.Collectors.toSet());

        Task task = new Task();
        task.setName(name);
        task.setDescription(description);
        task.setStatus(Task.Status.valueOf(status));
        task.setDeadline(LocalDate.parse(deadlineStr));
        task.setProject(project);
        task.setAssignedUsers(assignedUsers);

        return task;
    }


}
