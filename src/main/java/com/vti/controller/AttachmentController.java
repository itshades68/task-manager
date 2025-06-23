package com.vti.controller;

import com.vti.model.Attachment;
import com.vti.service.AttachmentService;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/attachments")
public class AttachmentController {

    private final AttachmentService attachmentService;

    public AttachmentController(AttachmentService attachmentService) {
        this.attachmentService = attachmentService;
    }

    // Upload file
    @PostMapping("/task/{taskId}")
    public ResponseEntity<Attachment> upload(@PathVariable Integer taskId,
                                             @RequestParam("file") MultipartFile file,
                                             Principal principal) {
        return ResponseEntity.ok(attachmentService.upload(taskId, file, principal.getName()));
    }

    // Danh sách file theo task
    @GetMapping("/task/{taskId}")
    public ResponseEntity<List<Attachment>> getByTask(@PathVariable Integer taskId) {
        return ResponseEntity.ok(attachmentService.getByTask(taskId));
    }

    // Tải file
    @GetMapping("/download/{id}")
    public ResponseEntity<Resource> download(@PathVariable Integer id) {
        Resource file = attachmentService.download(id);
        Attachment attachment = attachmentService.getMetadata(id);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + attachment.getFileName() + "\"")
                .body(file);
    }

    // Xem file
    @GetMapping("/preview/{id}")
    public ResponseEntity<Resource> preview(@PathVariable Integer id) {
        Resource file = attachmentService.download(id);
        return ResponseEntity.ok().body(file);
    }

    // Xoá file (admin hoặc người tạo)
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id, Principal principal) {
        attachmentService.deleteAttachment(id, principal.getName());
        return ResponseEntity.noContent().build();
    }
}
