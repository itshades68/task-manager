package com.vti.service;

import com.vti.model.Project;
import com.vti.model.Task;
import com.vti.repository.ProjectMemberRepository;
import com.vti.repository.ProjectRepository;
import com.vti.repository.TaskRepository;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjectService {
	private final ProjectRepository projectRepository;
	private final ProjectMemberRepository projectMemberRepository;
	private final TaskService taskService;
	private final TaskRepository taskRepository;

	public ProjectService(ProjectRepository projectRepository, ProjectMemberRepository projectMemberRepository,
			TaskService taskService, TaskRepository taskRepository) {
		super();
		this.projectRepository = projectRepository;
		this.projectMemberRepository = projectMemberRepository;
		this.taskService = taskService;
		this.taskRepository = taskRepository;
	}

	public Project createProject(Project project) {
		return projectRepository.save(project);
	}

	public Project updateProject(Integer id, Project updated) {
		Project project = projectRepository.findById(id).orElseThrow();
		project.setName(updated.getName());
		project.setDescription(updated.getDescription());
		return projectRepository.save(project);
	}

	public void deleteProject(Integer projectId) {

		List<Task> tasks = taskRepository.findByProjectId(projectId);
		for (Task task : tasks) {
			Integer taskId = task.getId();
			taskService.deleteTask(taskId);
		}
		projectMemberRepository.deleteByProjectId(projectId);
		projectRepository.deleteById(projectId);
	}

	public List<Project> getAllProjects() {
		return projectRepository.findAll();
	}

	public Project getProjectById(Integer id) {
		return projectRepository.findById(id).orElseThrow();
	}
}
