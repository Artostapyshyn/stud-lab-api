package com.artostapyshyn.studlabapi.service.impl;

import com.artostapyshyn.studlabapi.dto.ReplyDto;
import com.artostapyshyn.studlabapi.entity.Comment;
import com.artostapyshyn.studlabapi.entity.Reply;
import com.artostapyshyn.studlabapi.entity.Student;
import com.artostapyshyn.studlabapi.exception.exceptions.ResourceNotFoundException;
import com.artostapyshyn.studlabapi.repository.CommentRepository;
import com.artostapyshyn.studlabapi.repository.ReplyRepository;
import com.artostapyshyn.studlabapi.service.MessageService;
import com.artostapyshyn.studlabapi.service.ReplyService;
import com.artostapyshyn.studlabapi.service.StudentService;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

    private final ReplyRepository replyRepository;

    private final CommentRepository commentRepository;

    private final StudentService studentService;

    private final MessageService messageService;

    @Override
    @Cacheable("repliesByCommentId")
    public List<Reply> findReplyByCommentId(Long commentId) {
        return replyRepository.findReplyByCommentId(commentId);
    }

    @Override
    @CacheEvict(value = {"repliesByCommentId", "repliesById"}, allEntries = true)
    public void addReplyToComment(ReplyDto replyDto, Long parentCommentId, Authentication authentication) {
        Comment parentComment = commentRepository.findById(parentCommentId)
                .orElseThrow(() -> new ResourceNotFoundException("Parent comment not found"));

        Long id = studentService.getAuthStudentId(authentication);
        Optional<Student> student = studentService.findById(id);
        if (student.isPresent()) {
            Reply reply = new Reply();
            reply.setReplyText(replyDto.getReplyText());

            List<Reply> replies = parentComment.getReplies();
            replies.add(reply);

            reply.setComment(parentComment);
            reply.setStudent(student.get());
            replyRepository.save(reply);

            Long studentId = parentComment.getStudent().getId();
            messageService.addMessageToStudent(studentId);
            messageService.updateNewMessageStatus(studentId, true);
        }
    }

    @Override
    @Cacheable("repliesById")
    public Optional<Reply> findById(Long id) {
        return replyRepository.findById(id);
    }

    @Override
    @CacheEvict(value = {"repliesByCommentId", "repliesById"}, allEntries = true)
    public Reply save(Reply reply) {
        return replyRepository.save(reply);
    }

    @Override
    @CacheEvict(value = {"repliesByCommentId", "repliesById"}, allEntries = true)
    public void delete(Reply reply) {
        replyRepository.delete(reply);
    }
}
