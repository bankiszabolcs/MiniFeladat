<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiniFeladat.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mini feladat</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="table">
  <thead>
                    <tr>
                        <th scope="col">Product ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Stock Quantity</th>
                        <th scope="col">Description</th>
                        <th scope="col">Category</th>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var product in ProductList) { %>
                        <tr>
                            <td><%: product.ProductId %></td>
                            <td><%: product.Name %></td>
                            <td><%: product.Price %></td>
                            <td><%: product.StockQuantity %></td>
                            <td><%: product.Description %></td>
                            <td><%: product.Category %></td>
                        </tr>
                    <% } %>
                </tbody>
</table>
        </div>
    </form>
</body>
</html>
