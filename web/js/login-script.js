// Chạy code này ngay khi trang tải xong
document.addEventListener("DOMContentLoaded", function() {
    
    // Đọc các tham số từ URL (ví dụ: ?tab=login&error=1)
    const urlParams = new URLSearchParams(window.location.search);
    const tab = urlParams.get('tab');
    const error = urlParams.get('error');
    
    let tabToClick = null;

    // 1. Kiểm tra xem có cần chuyển tab không
    if (tab === 'login' || error === '1') {
        // Nếu URL yêu cầu tab=login HOẶC có lỗi (error=1),
        // chúng ta tìm nút tab "Đăng nhập"
        tabToClick = document.querySelector(".tab-link[onclick*='login-form']");
        
    } else if (tab === 'register') {
        // Nếu URL yêu cầu tab=register, tìm nút tab "Đăng ký"
        tabToClick = document.querySelector(".tab-link[onclick*='register-form']");
    }

    // Nếu tìm thấy nút, giả lập một cú click để kích hoạt hàm switchTab
    if (tabToClick) {
        tabToClick.click(); 
    }
    
    // 2. Kiểm tra xem có lỗi đăng nhập không
    if (error === '1') {
        const errorDiv = document.getElementById('login-error-message');
        if (errorDiv) {
            // Chèn thông báo lỗi vào div
            errorDiv.innerText = 'Email hoặc mật khẩu không đúng!';
        }
    }
});

// Hàm switchTab cũ của bạn giữ nguyên
function switchTab(event, tabName, isLinkClick = false) {
    
    // Lấy tất cả các nội dung form và link tab
    let formContents = document.getElementsByClassName("form-content");
    // ... (toàn bộ code cũ của hàm này giữ nguyên) ...
}
function switchTab(event, tabName, isLinkClick = false) {
    
    // Lấy tất cả các nội dung form và link tab
    let formContents = document.getElementsByClassName("form-content");
    let tabLinks = document.getElementsByClassName("tab-link");

    // Ẩn tất cả nội dung form
    for (let i = 0; i < formContents.length; i++) {
        formContents[i].style.display = "none";
        formContents[i].classList.remove("active");
    }

    // Xóa class "active" khỏi tất cả các link tab
    for (let i = 0; i < tabLinks.length; i++) {
        tabLinks[i].classList.remove("active");
    }

    // Hiển thị form được chọn
    document.getElementById(tabName).style.display = "block";
    document.getElementById(tabName).classList.add("active");

    // Đánh dấu "active" cho tab tương ứng
    // Nếu người dùng bấm vào link "Đăng nhập ngay" (isLinkClick)
    // ta phải tìm đúng tab button để active
    if (isLinkClick) {
        for (let i = 0; i < tabLinks.length; i++) {
            // So sánh thuộc tính onclick của tab button
            if (tabLinks[i].getAttribute('onclick').includes(tabName)) {
                tabLinks[i].classList.add("active");
            }
        }
    } else {
        // Nếu người dùng bấm trực tiếp vào tab
        event.currentTarget.classList.add("active");
    }
}