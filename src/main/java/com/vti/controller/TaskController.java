package com.vti.controller;

import com.vti.model.Project;
import com.vti.model.Task;
import com.vti.model.Task.Status;
import com.vti.model.User;
import com.vti.repository.ProjectRepository;
import com.vti.repository.TaskRepository;
import com.vti.repository.UserRepository;
import com.vti.service.AuditLogService;
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
	private final AuditLogService auditLogService;
	private final TaskRepository taskRepository;

	public TaskController(TaskService taskService, UserRepository userRepository, ProjectRepository projectRepository,
			ProjectMemberService projectMemberService, AuditLogService auditLogService, TaskRepository taskRepository ) {
		this.taskService = taskService;
		this.userRepository = userRepository;
		this.projectRepository = projectRepository;
		this.projectMemberService = projectMemberService;
		this.auditLogService = auditLogService;
		this.taskRepository = taskRepository;
	}

	@PreAuthorize("hasRole('ADMIN')")
	@PostMapping
	public ResponseEntity<Task> create(@RequestBody Map<String, Object> request, Principal principal) {
		Task task = parseTaskFromRequest(request);
		Task created = taskService.createTask(task);

		String desc = "Tạo task ID " + created.getId() + ": " + created.getName() + " trong project ID "
				+ created.getProject().getId();
		auditLogService.log(principal.getName(), "CREATE", "Task", created.getId(), desc);

		return ResponseEntity.ok(created);
	}

	@PreAuthorize("hasRole('ADMIN')")
	@PutMapping("/{id}")
	public ResponseEntity<Task> update(@PathVariable Integer id, @RequestBody Map<String, Object> request,
			Principal principal) {
		Task task = parseTaskFromRequest(request);
		Task updated = taskService.updateTask(id, task);

		String desc = "Cập nhật task ID " + id + ": " + updated.getName();
		auditLogService.log(principal.getName(), "UPDATE", "Task", id, desc);

		return ResponseEntity.ok(updated);
	}

	@PreAuthorize("hasRole('ADMIN')")
	@DeleteMapping("/{id}")
	public ResponseEntity<Void> delete(@PathVariable Integer id, Principal principal) {
		taskService.deleteTask(id);

		String desc = "Xoá task ID " + id;
		auditLogService.log(principal.getName(), "DELETE", "Task", id, desc);

		return ResponseEntity.noContent().build();
	}

	@GetMapping("/project/{projectId}")
	public ResponseEntity<List<Task>> getByProject(@PathVariable Integer projectId, Principal principal) {
		User user = userRepository.findByUsername(principal.getName()).orElseThrow();

		if (!user.getRole().equals(User.Role.ADMIN)) {
			boolean isInProject = projectMemberService.isUserInProject(projectId, user.getId());
			if (!isInProject) {
				return ResponseEntity.status(403).build();
			}
		}

		return ResponseEntity.ok(taskService.getTasksByProject(projectId));
	}

	@PatchMapping("/{id}/status")
	public ResponseEntity<Task> updateStatus(@PathVariable Integer id, @RequestBody Task request, Principal principal) {
		Task updated = taskService.updateStatus(id, request.getStatus(), principal.getName());

		String desc = "Cập nhật trạng thái task ID " + id + " thành " + updated.getStatus();
		auditLogService.log(principal.getName(), "STATUS_CHANGE", "Task", id, desc);

		return ResponseEntity.ok(updated);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Task> getTaskById(@PathVariable Integer id, Principal principal) {
	    Task task = taskService.getTaskById(id);
	    User user = userRepository.findByUsername(principal.getName()).orElseThrow();

	    boolean isAdmin = user.getRole().equals(User.Role.ADMIN);
	    boolean isAssigned = task.getAssignedUsers().contains(user);
	    if (!isAdmin && !isAssigned) {
	        return ResponseEntity.status(403).body(null);
	    }

	    return ResponseEntity.ok(task);
	}

	@PreAuthorize("hasRole('ADMIN')")
	@PostMapping("/{id}/assign")
	public ResponseEntity<Task> assignUsers(@PathVariable Integer id, @RequestBody Map<String, List<Integer>> request,
			Principal principal) {
		List<Integer> userIds = request.get("userIds");
		Task updated = taskService.assignUsers(id, userIds);

		String desc = "Phân công user cho task ID " + id;
		auditLogService.log(principal.getName(), "ASSIGN", "Task", id, desc);

		return ResponseEntity.ok(updated);
	}

	private Task parseTaskFromRequest(Map<String, Object> request) {
	    Object idObj = request.get("id");
	    Task task;

	    if (idObj != null) {
	        Integer id;
	        if (idObj instanceof Number) {
	            id = ((Number) idObj).intValue();
	        } else if (idObj instanceof String) {
	            id = Integer.parseInt((String) idObj);
	        } else {
	            throw new IllegalArgumentException("Id không hợp lệ");
	        }

	        task = taskRepository.findById(id)
	                .orElseThrow(() -> new RuntimeException("Không tìm thấy task với id = " + id));
	    } else {
	        task = new Task();
	    }

	    // Gán project
	    Integer projectId;
	    Object projectIdObj = request.get("projectId");
	    if (projectIdObj instanceof Number) {
	        projectId = ((Number) projectIdObj).intValue();
	    } else if (projectIdObj instanceof String) {
	        projectId = Integer.parseInt((String) projectIdObj);
	    } else {
	        throw new IllegalArgumentException("projectId không hợp lệ");
	    }
	    Project project = projectRepository.findById(projectId)
	            .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy project với id = " + projectId));
	    task.setProject(project);

	    // Gán các field cơ bản
	    task.setName((String) request.get("name"));
	    task.setDescription((String) request.get("description"));
	    String deadlineStr = (String) request.get("deadline");
	    if (deadlineStr != null && !deadlineStr.isBlank()) {
	        task.setDeadline(LocalDate.parse(deadlineStr));
	    }
	 // Gán status nếu có
	    if (request.containsKey("status")) {
	        Object statusObj = request.get("status");
	        if (statusObj != null) {
	            try {
	                task.setStatus(Status.valueOf(statusObj.toString()));
	            } catch (IllegalArgumentException e) {
	                throw new IllegalArgumentException("Giá trị status không hợp lệ: " + statusObj);
	            }
	        }
	    }


	    // Gán danh sách assignedUsers nếu có
	    if (request.containsKey("assignedUsers")) {
	        List<Integer> userIds = (List<Integer>) request.get("assignedUsers");
	        Set<User> users = userIds.stream()
	            .map(uid -> userRepository.findById(uid)
	                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy user với id = " + uid)))
	            .collect(Collectors.toSet());
	        task.setAssignedUsers(users);
	    }

	    return task;
	}
}
