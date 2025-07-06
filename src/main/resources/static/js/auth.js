const API_BASE_URL = ""; // Cập nhật lại nếu backend dùng port khác

$(document).ready(() => {
  $('#loginForm').on('submit', function (e) {
    e.preventDefault();

    const username = $('#username').val().trim();
    const password = $('#password').val();

    // ✅ Validate phía client
    if (!username || !password) {
      return showError("Vui lòng điền đầy đủ tài khoản và mật khẩu.");
    }
    if (password.length < 6) {
      return showError("Mật khẩu phải có ít nhất 6 ký tự.");
    }

    $.ajax({
      url: `${API_BASE_URL}/auth/login`,
      method: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({ username, password }),
      success: function (res) {
        localStorage.setItem('token', res.token);
        localStorage.setItem('user', JSON.stringify(res.user));
        window.location.href = 'projects.html';
      },
      error: function (err) {
        if (err.status === 401 || err.status === 403) {
          showError("Tài khoản hoặc mật khẩu không đúng.");
        } else {
          showError("Đã có lỗi xảy ra, vui lòng thử lại sau.");
        }
      }
    });
  });

  function showError(msg) {
    $('#errorMsg').text(msg).removeClass('d-none');
  }
});
