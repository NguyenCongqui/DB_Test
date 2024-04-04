--Làm thế nào để lấy danh sách hàng hóa ?
SELECT * from LS_Products
--Lấy các thông tin tương ứng với trường hiển thị trên Form hàng hóa?
select s_Product_Id,LS_Products.s_Name, s_Unit,m_UnitPrice,m_unitpurchase, LS_ProductGroups.s_Name  from 
LS_Products join ls_productgroups on LS_ProductGroups.s_ID = LS_Products.s_ProductGroupID
--Làm thế nào để lấy danh sách khách hàng ?
SELECT * FROM dbo.LS_Objects
--Lấy các thông tin tương ứng với trường hiển thị trên Form khách hàng?
SELECT s_Object_ID, s_Name, s_Phone1,s_Address, s_Email, s_Note  FROM dbo.LS_Objects
--Làm thế nào để lấy danh sách nhân viên ?
SELECT * FROM dbo.LS_Employees
--Làm thế nào để lấy danh sách người dùng ?
SELECT * FROM dbo.LS_USER
-- Làm thế nào để lấy danh sách kho hàng ?
SELECT * FROM dbo.LS_Stores
-- Làm thế nào để lấy danh sách nhóm hàng
SELECT * FROM LS_ProductGroups
--Làm thế nào để lấy danh sách lý do thu khác
SELECT *FROM LS_OtherIncome
--Làm thế nào để lấy danh sách lý do chi khác?
SELECT * FROM LS_OtherOutcome
-- Làm thế nào để lấy danh sách lý do nhập khác?
SELECT * FROM Ls_Import_Other
--Làm thế nào để lấy danh sách lý do xuất khác?
SELECT * FROM Ls_Order_Other
--  Làm thế nào để lấy danh sách tiền tệ
SELECT * FROM LS_Currency
-- Làm thế nào để lấy danh sách kỳ hạn thanh toán
SELECT * FROM LS_PaymentTerm
-- Làm thế nào để lấy danh sách hóa đơn bán hàng trong ngày 
SELECT * FROM dbo.Ls_Orders WHERE dt_OrderDate = GETDATE()
-- Làm thế nào để lấy danh sách hóa đơn nhập hàng trong ngày 
SELECT * FROM dbo.Ls_Imports 
--Làm thế nào để lấy danh sách hóa đơn thu tiền trong ngày
SELECT * FROM dbo.LS_Income WHERE dt_Edit = GETDATE()
--Làm thế nào để lấy danh sách hóa đơn chi tiền trong ngày 
SELECT * FROM dbo.PR_OutcomePaymentType
-- Lấy danh sách hóa đơn bán hàng đã thu tiền ?
SELECT * FROM LS_Orders 
--18. Lấy danh sách hóa đơn thu tiền tương ứng cho một hóa đơn bán ở trạng thái "Đã thu" ?

--19. Lấy danh sách hóa đơn bán hàng tương ứng cho một hóa đơn thu tiền ?
--20. Lấy danh sách hóa đơn đặt hàng nhập ?
GO 
SELECT * FROM dbo.LS_PurchaseImports
--21. Lấy danh sách hóa đơn đặt hàng nhập ở các trạng thái: hoàn thành, nhập đủ, nhập thiếu, chưa nhập, đã hủy?
SELECT * FROM LS_PurchaseImports
--22. Lấy danh sách hóa đơn đặt hàng xuất ?
SELECT * FROM dbo.LS_OrderReturns
--23. Lấy danh sách hóa đơn đặt hàng xuất ở các trạng thái: hoàn thành, xuất đủ, xuất thiếu, chưa xuất, đã hủy?
SELECT * FROM dbo.LS_OrderReturns
--24. Lấy danh sách hóa đơn nhập khác?
SELECT * FROM dbo.PR_ImportDetail_Other
---25. Lấy danh sách hóa đơn xuất khác?
SELECT * FROM Ls_Order_Other
--26. Lấy danh sách các đơn xuất trả hàng?
SELECT * FROM dbo.LS_OrderReturns
--27. Lấy danh sách các đơn nhập hàng trả?
SELECT * FROM dbo.Ls_ImportReturns
--28. Lấy danh sách hóa đơn chuyển kho?
SELECT * FROM dbo.LS_Trans
--29. Lấy danh sách hóa đơn luân chuyển tiền tệ?
SELECT * FROM dbo.Ls_TransCurr
--30. Lấy danh sách hóa đơn chi tiền theo: tiền mặt, chuyển khoản, luân chuyển tiền tệ?
SELECT * FROM dbo.LS_Outcome
--31. Lấy danh sách hóa đơn thu tiền theo: tiền mặt, chuyển khoản, luân chuyển tiền tệ?
SELECT * FROM dbo.LS_Income
--------- Phần nâng cao -------
--33. Tính doanh số bán hàng trong ngày? theo khoảng thời gian tùy chọn?
SELECT SUM(m_Ordertotal) AS DoanhSoBanHang
FROM dbo.Ls_Orders
WHERE dt_OrderDate BETWEEN '2023-01-01' AND '2024-01-31';
--34. Tính doanh số bán hàng trong ngày của nhân viên? theo khoảng thời gian tùy chọn ?
SELECT s_Employee_ID, dt_OrderDate, SUM(m_Ordertotal) AS doanhso FROM dbo.Ls_Orders INNER JOIN dbo.LS_Employees ON LS_Employees.s_ID = Ls_Orders.s_EmployeeID
WHERE dt_OrderDate BETWEEN '2023-01-01' AND '2024-01-31'
GROUP BY s_Employee_ID, dt_OrderDate
ORDER BY dt_OrderDate, s_Employee_ID;
--35. Tính doanh số bán hàng trong ngày theo kho hàng? theo khoảng thời gian tùy chọn ?
SELECT LS_Stores.s_Store_ID,  CONVERT(VARCHAR, dt_OrderDate, 111) AS sales_date, SUM(m_Ordertotal) AS total_sales
FROM dbo.Ls_Orders INNER JOIN dbo.LS_Stores ON LS_Stores.s_Store_ID = Ls_Orders.s_Store_ID
WHERE dt_OrderDate BETWEEN '2023-01-01' AND '2024-01-31'
GROUP BY LS_Stores.s_Store_ID, CONVERT(VARCHAR, dt_OrderDate, 111)
--36. Tính công nợ khách hàng tới thời điểm hiện tại?
--37. Tính tổng tiền tích lũy của khách hàng tới thời điểm hiện tại?
SELECT s_Name,SUM(m_Ordertotal) AS TongTienTichLuy FROM 
	dbo.Ls_Orders INNER JOIN dbo.LS_Objects 
	ON LS_Objects.s_ID = Ls_Orders.s_ObjectID
	WHERE dt_OrderDate <= GETDATE()  -- Lọc các giao dịch tới thời điểm hiện tại
GROUP BY s_Name
ORDER BY TongTienTichLuy DESC;  -- Sắp xếp theo tổng tiền tích lũy giảm dần
--38. Kết quả hoạt động kinh doanh theo ngày: ?
--	- Số lượng hàng bán
--	- Số lượng hàng nhập
--	- Số lượng hàng trả
--	- Tổng thu trên hóa đơn
--	- Tổng thu khác
--	- Tổng chi trên hóa đơn
--	- Tổng chi khác 
...
39. Viết báo cáo tính giá vốn sản phẩm theo giá vốn bình quân
40. Viết báo cáo tính giá vốn sản phẩm theo giá vốn FIFO
41. Viết báo cáo cảnh báo hạn dùng sản phẩm theo FIFO

