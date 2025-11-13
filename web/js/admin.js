/* * File JS tùy chỉnh cho trang Admin
 * PHIÊN BẢN BIỂU ĐỒ CỘT (BAR CHART)
 */

$(document).ready(function() {
    
    // Kiểm tra xem chartLabels và chartData có tồn tại không (được nhúng từ admin/admin.jsp)
    if (typeof chartLabels !== 'undefined' && typeof chartData !== 'undefined') {
        
        var ctx = document.getElementById('myRevenueChart').getContext('2d');
        
        // SỬA: Dùng một mảng màu cho 7 cột
        // (Bạn có thể dùng 1 màu duy nhất nếu muốn, ví dụ: 'rgba(230, 57, 70, 0.7)')
        var barColors = [
            'rgba(255, 99, 132, 0.7)',
            'rgba(54, 162, 235, 0.7)',
            'rgba(255, 206, 86, 0.7)',
            'rgba(75, 192, 192, 0.7)',
            'rgba(153, 102, 255, 0.7)',
            'rgba(255, 159, 64, 0.7)',
            'rgba(230, 57, 70, 0.7)'
        ];
        
        // SỬA: Tạo border đậm hơn cho các cột
        var borderColors = barColors.map(color => color.replace('0.7', '1'));

        var myRevenueChart = new Chart(ctx, {
            type: 'bar', // SỬA: Đổi type sang 'bar'
            data: {
                labels: chartLabels, 
                datasets: [{
                    label: 'Doanh thu',
                    data: chartData, 
                    backgroundColor: barColors, // SỬA: Dùng mảng màu nền
                    borderColor: borderColors,  // SỬA: Dùng mảng màu viền
                    borderWidth: 1,
                    borderRadius: 5, // Bo góc nhẹ cho các cột
                    hoverBackgroundColor: borderColors // Đậm màu hơn khi di chuột
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            // Format tiền tệ "100.000 VNĐ"
                            callback: function(value, index, values) {
                                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                            }
                        }
                    },
                    x: {
                        grid: {
                            display: false // Ẩn đường lưới trục X cho gọn
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false // Ẩn chú thích "Doanh thu"
                    },
                    tooltip: {
                        backgroundColor: '#333',
                        titleFont: {
                            size: 14,
                            weight: 'bold'
                        },
                        bodyFont: {
                            size: 13
                        },
                        padding: 10,
                        cornerRadius: 6,
                        displayColors: false, // Ẩn ô vuông màu
                        callbacks: {
                            label: function(context) {
                                var label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    }
});