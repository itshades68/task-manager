package com.vti.controller;

import com.vti.model.Comment;
import com.vti.model.CommentHistory;
import com.vti.service.CommentService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comments")
public class CommentController {

	private final CommentService commentService;

	public CommentController(CommentService commentService) {
		this.commentService = commentService;
	}

	// ✅ Thêm comment vào task (ai cũng dùng được)
	@PostMapping("/task/{taskId}")
	public ResponseEntity<Comment> createComment(@PathVariable Integer taskId, @RequestBody Map<String, String> request,
			Principal principal) {
		String content = request.get("content");
		return ResponseEntity.ok(commentService.createComment(taskId, content, principal.getName()));
	}

	// ✅ Lấy tất cả comment của task (ai cũng dùng được)
	@GetMapping("/task/{taskId}")
	public ResponseEntity<List<Comment>> getCommentsByTask(@PathVariable Integer taskId) {
		return ResponseEntity.ok(commentService.getCommentsByTask(taskId));
	}

	// ✅ Chỉ ADMIN được xoá comment
	@PreAuthorize("hasRole('ADMIN')")
	@DeleteMapping("/{commentId}")
	public ResponseEntity<Void> deleteComment(@PathVariable Integer commentId, Principal principal) {
		commentService.deleteComment(commentId, principal.getName());
		return ResponseEntity.noContent().build();
	}

	// ✅ ADMIN hoặc NGƯỜI TẠO được sửa comment
	@PatchMapping("/{commentId}")
	public ResponseEntity<Comment> updateComment(@PathVariable Integer commentId,
			@RequestBody Map<String, String> request, Principal principal) {
		String newContent = request.get("content");
		return ResponseEntity.ok(commentService.updateComment(commentId, newContent, principal.getName()));
	}

	@GetMapping("/{commentId}/history")
	public ResponseEntity<List<CommentHistory>> getCommentHistory(@PathVariable Integer commentId) {
		return ResponseEntity.ok(commentService.getCommentHistory(commentId));
	}
}
