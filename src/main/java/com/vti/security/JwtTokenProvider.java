package com.vti.security;

import com.vti.model.User;
import com.vti.repository.UserRepository;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;
import java.util.List;

@Component
public class JwtTokenProvider {

	private final Key key = Keys.secretKeyFor(SignatureAlgorithm.HS512);
	private final long expiration = 86400000; // 1 ngày

	@Autowired
	private UserRepository userRepository;

	// Sinh token có chứa ROLE chuẩn cho Spring Security
	public String generateToken(String username) {
		User user = userRepository.findByUsername(username)
				.orElseThrow(() -> new RuntimeException("User không tồn tại"));

		Claims claims = Jwts.claims().setSubject(username);
		claims.put("roles", List.of("ROLE_" + user.getRole().name())); // rất quan trọng!

		Date now = new Date();
		Date expiry = new Date(now.getTime() + expiration);

		return Jwts.builder().setClaims(claims).setIssuedAt(now).setExpiration(expiry).signWith(key).compact();
	}

	// Lấy username từ token
	public String getUsernameFromToken(String token) {
		return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token).getBody().getSubject();
	}

	// Lấy danh sách quyền (roles) từ token
	public List<String> getRolesFromToken(String token) {
		Claims claims = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token).getBody();

		return (List<String>) claims.get("roles");
	}

	// Kiểm tra token hợp lệ hay không
	public boolean validateToken(String token) {
		try {
			Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
			return true;
		} catch (JwtException | IllegalArgumentException e) {
			return false;
		}
	}
}
