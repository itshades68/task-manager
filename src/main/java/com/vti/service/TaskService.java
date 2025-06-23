package com.vti.service;

import com.vti.model.Project;
import com.vti.model.Task;
import com.vti.model.User;
import com.vti.repository.ProjectRepository;
import com.vti.repository.TaskRepository;
import com.vti.repository.UserRepository;
import com.vti.service.ProjectMemberService;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class TaskService {
    private final TaskRepository taskRepository;
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final ProjectMemberService projectMemberService;

    public TaskService(TaskRepository taskRepository,
                       ProjectRepository projectRepository,
                       UserRepository userRepository,
                       ProjectMemberService projectMemberService) {
        this.taskRepository = taskRepository;
        this.projectRepository = projectRepository;
        this.userRepository = userRepository;
        this.projectMemberService = projectMemberService;
    }

    public Task createTask(Task task) {
        return taskRepository.save(task);
    }

    public Task updateTask(Integer taskId, Task updatedTask) {
        Task task = taskRepository.findById(taskId).orElseThrow();
        task.setName(updatedTask.getName());
        task.setDescription(updatedTask.getDescription());
        task.setDeadline(updatedTask.getDeadline());
        task.setStatus(updatedTask.getStatus());
        task.setProject(updatedTask.getProject());
        task.setAssignedUsers(updatedTask.getAssignedUsers());
        return taskRepository.save(task);
    }

    public void deleteTask(Integer taskId) {
        taskRepository.deleteById(taskId);
    }

    public List<Task> getTasksByProject(Integer projectId) {
        Project project = projectRepository.findById(projectId).orElseThrow();
        return taskRepository.findByProject(project);
    }

    public List<Task> getTasksAssignedToUser(User user) {
        return taskRepository.findByAssignedUsersContaining(user);
    }

    public Task updateStatus(Integer taskId, Task.Status status, String username) {
        Task task = taskRepository.findById(taskId).orElseThrow();
        User user = userRepository.findByUsername(username).orElseThrow();

        if (!task.getAssignedUsers().contains(user)) {
            throw new SecurityException("Không có quyền cập nhật task này");
        }

        task.setStatus(status);
        return taskRepository.save(task);
    }
}
