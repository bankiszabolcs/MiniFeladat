﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiniFeladat.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mini feladat</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/font-awesome.min.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <asp:HiddenField ID="hfProductId" runat="server" />
        <asp:HiddenField ID="hfProductName" runat="server" />
        <asp:HiddenField ID="hfProductPrice" runat="server" />
        <asp:HiddenField ID="hfProductStockQuantity" runat="server" />
        <asp:HiddenField ID="hfProductDescription" runat="server" />
        <asp:HiddenField ID="hfProductCategory" runat="server" />
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Navbar</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Link</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Action</a></li>
                                <li><a class="dropdown-item" href="#">Another action</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="#">Something else here</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                        </li>
                    </ul>
                    <form class="d-flex" role="search">
                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-success" type="submit">Search</button>
                    </form>
                </div>
            </div>
        </nav>
        <div class="container mt-3">
            <div class="row">
                <div class="col">
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th class="text-center" scope="col">Product ID</th>
                                <th class="text-center" scope="col">Name</th>
                                <th class="text-center" scope="col">Price</th>
                                <th class="text-center" scope="col">Stock Quantity</th>
                                <th class="text-center" scope="col">Description</th>
                                <th class="text-center" scope="col">Category</th>
                                <th class="text-center" scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var product in ProductList)
                                { %>
                            <tr id="productRow_<%: product.ProductId %>">
                                <td class="text-center align-middle"><%: product.ProductId %></td>
                                <td class="text-center align-middle"><%: product.Name %></td>
                                <td class="text-center align-middle"><%: product.Price %></td>
                                <td class="text-center align-middle"><%: product.StockQuantity %></td>
                                <td class="text-center align-middle"><%: product.Description %></td>
                                <td class="text-center align-middle"><%: product.Category %></td>
                                <td class="align-middle">
                                    <div class="d-flex justify-content-center column-gap-2">
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal" onclick="showEditModal('<%: product.ProductId %>', '<%: product.Name %>', '<%:product.Price %>', '<%:product.StockQuantity %>', '<%:product.Description %>', '<%:product.Category %>')">
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="showDeleteModal('<%: product.ProductId %>', '<%: product.Name %>')">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="deleteModal" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Elem törlése</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this item?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Mégsem</button>
                        <button type="button" class="btn btn-danger" onclick="deleteItem()" data-bs-dismiss="modal">Törlés</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div id="editModal" class="modal fade" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Edit Item</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="editForm">
                            <div class="mb-3">
                                <label for="editProductName" class="form-label">Name:</label>
                                <input type="text" class="form-control" id="editProductName" />
                            </div>
                            <div class="mb-3">
                                <label for="editProductPrice" class="form-label">Price:</label>
                                <input type="text" class="form-control" id="editProductPrice" />
                            </div>
                            <div class="mb-3">
                                <label for="editProductStockQuantity" class="form-label">Stock Quantity:</label>
                                <input type="text" class="form-control" id="editProductStockQuantity" />
                            </div>
                            <div class="mb-3">
                                <label for="editProductDescription" class="form-label">Description:</label>
                                <textarea class="form-control" id="editProductDescription"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="editProductCategory" class="form-label">Category:</label>
                                <select class="form-select" id="editProductCategory">
                                    <option value="Electronics">Electronics</option>
                                    <option value="Apparel">Apparel</option>
                                    <option value="Home">Home</option>
                                    <option value="Clothes">Clothes</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="updateProduct()">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>


        <script>

            function showDeleteModal(productId, productName) {
                document.getElementById('<%= hfProductId.ClientID %>').value = productId
                document.querySelector('.modal-body').innerHTML = `Biztos vagy benne, hogy törlöd <strong>${productName}</strong>?`

            }

            function deleteItem() {
                const productId = document.getElementById('<%= hfProductId.ClientID %>').value;
                PageMethods.DeleteProduct(productId, onDeleteSuccess, onDeleteFailure);
            }

            function onDeleteSuccess(productId) {
                var deletedRow = document.getElementById('productRow_' + productId);
                if (deletedRow) {
                    deletedRow.remove();
                }
            }

            function onDeleteFailure(error) {
                console.error(error.get_message());
            }

            function showEditModal(id, name, price, stockQuantity, description, category) {

                document.getElementById('<%= hfProductId.ClientID %>').value = id;

                document.getElementById('editProductName').value = name;
                document.getElementById('editProductPrice').value = price;
                document.getElementById('editProductStockQuantity').value = stockQuantity;
                document.getElementById('editProductDescription').value = description;
                document.getElementById('editProductCategory').value = category;

            }

            // Function to handle updating the product
            function updateProduct() {

                document.getElementById('<%= hfProductName.ClientID %>').value = document.getElementById('editProductName').value;
                document.getElementById('<%= hfProductPrice.ClientID %>').value = document.getElementById('editProductPrice').value;
                document.getElementById('<%= hfProductStockQuantity.ClientID %>').value = document.getElementById('editProductStockQuantity').value;
                document.getElementById('<%= hfProductDescription.ClientID %>').value = document.getElementById('editProductDescription').value;
                document.getElementById('<%= hfProductCategory.ClientID %>').value = document.getElementById('editProductCategory').value;

                const productId = document.getElementById('<%= hfProductId.ClientID %>').value;
                const name = document.getElementById('<%= hfProductName.ClientID %>').value;
                const price = document.getElementById('<%= hfProductPrice.ClientID %>').value;
                const stockQuantity = document.getElementById('<%= hfProductStockQuantity.ClientID %>').value;
                const description = document.getElementById('<%= hfProductDescription.ClientID %>').value;
                const category = document.getElementById('<%= hfProductCategory.ClientID %>').value;
                
                PageMethods.UpdateProduct(productId, name, price, stockQuantity, description, category, onUpdateSuccess, onUpdateFailure);
            }

            // Callback function for successful product update
            function onUpdateSuccess(productId) {
                var row = document.getElementById('productRow_' + productId);
                if (row) {
                    row.cells[1].innerText = document.getElementById('<%= hfProductName.ClientID %>').value;
                    row.cells[2].innerText = document.getElementById('<%= hfProductPrice.ClientID %>').value;
                    row.cells[3].innerText = document.getElementById('<%= hfProductStockQuantity.ClientID %>').value;
                    row.cells[4].innerText = document.getElementById('<%= hfProductDescription.ClientID %>').value;
                    row.cells[5].innerText = document.getElementById('<%= hfProductCategory.ClientID %>').value;
                };
            }

            // Callback function for product update failure
            function onUpdateFailure(error) {
                // Handle update failure, such as displaying an error message
                console.error(error.get_message());
            }

        </script>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</body>
</html>
