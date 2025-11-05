/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* JavaScript tùy chỉnh cho trang admin */

(function($) {
    
    // Bước 1: Lấy dữ liệu từ biến toàn cục (được định nghĩa trong admin.jsp)
    // Biến 'chartLabels' và 'chartData' phải được khai báo trong admin.jsp
    
    // Bước 2: Vẽ biểu đồ
    // Thêm kiểm tra nếu có dữ liệu thì mới vẽ
    if (typeof chartData !== 'undefined' && chartData.length > 0) {
        var ctx = document.getElementById('myRevenueChart').getContext('2d');
        var myRevenueChart = new Chart(ctx, {
            type: 'line', // Bạn có thể đổi thành 'bar' nếu muốn
            data: {
                labels: chartLabels, // Sử dụng biến toàn cục
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: chartData, // Sử dụng biến toàn cục
                    backgroundColor: 'rgba(0, 123, 255, 0.2)', // Màu nền
                    borderColor: 'rgba(0, 123, 255, 1)',     // Màu đường viền
                    borderWidth: 2,
                    fill: true,
                    tension: 0.1 // Làm cho đường cong mượt hơn
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        // Định dạng trục Y (trục tiền)
                        ticks: {
                            callback: function(value, index, values) {
                                return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                            }
                        }
                    }
                },
                plugins: {
                    // Định dạng khi di chuột vào (tooltip)
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += new Intl.NumberFormat('vi-VN').format(context.parsed.y) + ' VNĐ';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    } else if (document.getElementById('myRevenueChart')) { 
        // Nếu không có dữ liệu, hiển thị thông báo
        var canvas = document.getElementById('myRevenueChart');
        var ctx = canvas.getContext('2d');
        ctx.font = "16px Arial";
        ctx.fillStyle = "#888";
        ctx.textAlign = "center";
        ctx.fillText("Chưa có dữ liệu doanh thu (Đơn hàng 'Đã giao') trong 7 ngày qua.", canvas.width / 2, 50);
    }
    // ===============================================
    // MỚI: LOGIC XEM TRƯỚC ẢNH SẢN PHẨM
    // ===============================================

    // 1. Tìm các phần tử trên trang
    var hinhAnhInput = document.getElementById('hinhAnhInput');
    var imagePreview = document.getElementById('imagePreview');

    // 2. Hàm để cập nhật ảnh
    function updateImagePreview() {
        // Kiểm tra xem các phần tử có tồn tại không
        if (!hinhAnhInput || !imagePreview) return; 

        var link = hinhAnhInput.value;
        if (link) {
            imagePreview.src = link; // Đặt nguồn ảnh
            imagePreview.style.display = 'block'; // Hiển thị ảnh
        } else {
            imagePreview.style.display = 'none'; // Ẩn nếu không có link
        }
    }

    // 3. Gán sự kiện
    // (Kiểm tra xem hinhAnhInput có tồn tại trên trang này không)
    if (hinhAnhInput) {
        
        // Chạy khi người dùng click ra khỏi ô input
        hinhAnhInput.addEventListener('blur', updateImagePreview);
        
        // Chạy khi người dùng dán link vào
        hinhAnhInput.addEventListener('paste', function() {
            // Cần một độ trễ nhỏ để value kịp cập nhật
            setTimeout(updateImagePreview, 100);
        });
        
        // Cập nhật ngay khi tải trang (dành cho trang Sửa sản phẩm)
        updateImagePreview();
    }
})(jQuery);