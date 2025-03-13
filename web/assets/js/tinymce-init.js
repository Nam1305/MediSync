

document.addEventListener("DOMContentLoaded", function () {
    tinymce.init({
        selector: '#testResults',
        plugins: 'image code fullscreen',
        toolbar: 'undo redo | bold italic underline | alignleft aligncenter alignright | image link | fullscreen code',
        image_title: true,
        automatic_uploads: true,
        images_upload_url: 'uploadimage',
        file_picker_types: 'image',
        setup: function (editor) {
            editor.on('input', function () {
                document.getElementById("submitBtn").disabled = false; // Bật nút submit khi có nhập nội dung
            });
        },
        file_picker_callback: function (cb) {
            var input = document.createElement('input');
            input.setAttribute('type', 'file');
            input.setAttribute('accept', 'image/*');
            input.onchange = function () {
                var file = this.files[0];
                if (!file) {
                    alert("Không có tệp nào được chọn.");
                    return;
                }

                var allowedExtensions = ['jpg', 'jpeg', 'png', 'dcm'];
                var fileName = file.name.toLowerCase();
                var fileExtension = fileName.split('.').pop();
                if (!allowedExtensions.includes(fileExtension)) {
                    alert("Chỉ được tải lên các file hình ảnh có đuôi: .jpg, .jpeg, .png, .dcm.");
                    return;
                }

                if (file.size > 10 * 1024 * 1024) {
                    alert("Kích thước tệp quá lớn! Chỉ được tải lên ảnh dưới 10MB.");
                    return;
                }

                var formData = new FormData();
                formData.append('file', file);
                fetch('uploadimage', {
                    method: 'POST',
                    body: formData
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                cb(data.location, {title: file.name});
                            } else {
                                alert("Lỗi khi tải ảnh lên: " + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Upload failed:', error);
                            alert("Có lỗi xảy ra khi tải ảnh lên, vui lòng thử lại.");
                        });
            };
            input.click();
        }
    });
});