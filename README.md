# MSA Market Sales App Project
## Giới thiệu chung
Hệ thống MSA hỗ trợ quản lý mối quan hệ khách hàng, đơn hàng, sản phẩm, hàng tồn kho, thanh toán và vận chuyển cho cửa hàng trực tuyến. Hệ thống này tích hợp với nền tảng android app từ frontend, đảm bảo hoạt động trơn tru và tầm nhìn thống nhất về tương tác khách hàng.

## Yêu cầu

### 1. Tài khoản admin
- **Quản lý sản phẩm:**
  - Mô tả:
    Giao diện quản lý sản phẩm trực quan, hiển thị thông tin chi tiết (tên sản phẩm, mô tả, hình ảnh, giá cả, số lượng tồn kho, danh mục).
    Tìm kiếm sản phẩm nhanh chóng theo nhiều tiêu chí (tên, mã sản phẩm, danh mục).
    Thêm sản phẩm mới với đầy đủ thông tin.
    Sửa thông tin sản phẩm đã tồn tại.
    Xóa sản phẩm.
    Cập nhật số lượng tồn kho theo thời gian thực.
  - Ưu tiên: Cao
- **Quản lý mã giảm giá:**
  - Mô tả:
    Tạo mã giảm giá mới với các thông tin chi tiết (mã giảm giá, phần trăm giảm giá, giá trị giảm giá, điều kiện áp dụng, thời gian bắt đầu, thời gian           kết thúc).
    Sửa thông tin mã giảm giá đã tồn tại.
    Xóa mã giảm giá.
  - Ưu tiên: Trung bình
- **Quản lý khách hàng:**
  - Mô tả:
    Xem, tìm kiếm khách hàng: Admin có thể tra cứu danh sách khách hàng, tìm kiếm theo tên hoặc thông tin liên hệ.
    Sửa thông tin khách hàng: Admin có quyền chỉnh sửa thông tin của khách hàng (ví dụ: địa chỉ, số điện thoại).
    Xóa khách hàng: Trong trường hợp cần thiết, admin có thể xóa tài khoản khách hàng.
  - Ưu tiên: Cao
- **Quản lý đơn hàng:**
  - Mô tả:
    Danh sách đơn hàng với các trạng thái khác nhau (đang chờ xác nhận, đang giao hàng, đã giao hàng, đã hủy).
    Chi tiết đơn hàng: sản phẩm, số lượng, giá, thông tin khách hàng, địa chỉ giao hàng, phương thức thanh toán.
    Tìm kiếm đơn hàng theo mã đơn hàng, ngày đặt hàng, khách hàng.
    Sửa thông tin đơn hàng.
    Hủy đơn hàng.
  - Ưu tiên: Cao
### 2. Tài khoản khách hàng
- **Đăng ký, đăng nhập:**
  - Mô tả:
    Giao diện đăng ký trực quan, yêu cầu thông tin cơ bản (email xác nhận, mật khẩu sẽ được mã hóa).
    Đăng nhập bằng tài khoản Google.
    Quên mật khẩu và đặt lại mật khẩu.
  - Ưu tiên: Cao
- **Quản lý thông tin cá nhân:**
  - Mô tả:
    Cập nhật thông tin cá nhân (tên, địa chỉ, số điện thoại, email).
    Thay đổi mật khẩu.
  - Ưu tiên: Cao
- **Tìm kiếm sản phẩm:**
  - Mô tả:
    Thanh tìm kiếm thông minh, cho phép tìm kiếm theo tên sản phẩm, danh mục, giá.
    Lọc sản phẩm theo các tiêu chí khác (ví dụ: thương hiệu, màu sắc, kích cỡ).
  - Ưu tiên: Cao
- **Thêm sản phẩm vào giỏ hàng:**
  - Mô tả:
    Thêm sản phẩm vào giỏ hàng, cập nhật số lượng, xóa sản phẩm.
    Tính tổng tiền đơn hàng, áp dụng mã giảm giá.
  - Ưu tiên: Cao
- **Sử dụng mã giảm giá:**
  - Mô tả:
    Người dùng có thể nhập mã giảm giá vào giỏ hàng và hệ thống sẽ kiểm tra xem mã giảm giá có hợp lệ và áp dụng được hay không.
  - Ưu tiên: Trung bình
- **Đặt hàng:**
  - Mô tả:
    Người dùng có thể chọn sản phẩm từ giỏ hàng, điền địa chỉ giao hàng và tiến hành đặt hàng.
  - Ưu tiên: Cao
- **Hỗ trợ:**
  - Mô tả:
    Người dùng có thể gửi tin nhắn hỗ trợ hoặc yêu cầu trợ giúp tới tổng đài chăm sóc khách hàng.
  - Ưu tiên: Trung bình
- **Thanh toán:**
  - Mô tả:
    Tích hợp nhiều phương thức thanh toán (thẻ tín dụng, ví điện tử).
    Hiển thị thông tin thanh toán chi tiết.
  - Ưu tiên: Cao
- **Chọn phương thức vận chuyển:**
  - Mô tả:
    Người dùng có thể chọn phương thức vận chuyển phù hợp và xem chi phí vận chuyển tương ứng trước khi xác nhận đơn hàng.
  - Ưu tiên: Cao

