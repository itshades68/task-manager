package com.vti.repository;

import com.vti.model.Project;
import com.vti.model.Task;
import com.vti.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TaskRepository extends JpaRepository<Task, Integer> {
	List<Task> findByProject(Project project);

	List<Task> findByAssignedUsersContaining(User user);

	List<Task> findByProjectAndAssignedUsersContaining(Project project, User user);

	Optional<Task> findById(Integer id);

	List<Task> findByProjectId(Integer projectId);
}
