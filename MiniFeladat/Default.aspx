<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiniFeladat.Default" %>

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
                    <table class="table table-hover">
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
                                <td class="text-center"><%: product.ProductId %></td>
                                <td class="text-center"><%: product.Name %></td>
                                <td class="text-center"><%: product.Price %></td>
                                <td class="text-center"><%: product.StockQuantity %></td>
                                <td class="text-center"><%: product.Description %></td>
                                <td class="text-center"><%: product.Category %></td>
                                <td class="align-middle">
                                    <div class="d-flex justify-content-center column-gap-2">
                                        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editModal" onclick="showEditModal('<%: product.ProductId %>', '<%: product.Name %>')">
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
        <!-- Modal for deletion confirmation -->
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

        <script>

            function showDeleteModal(productId, productName) {
                document.getElementById('<%= hfProductId.ClientID %>').value = productId
                document.querySelector('.modal-body').innerHTML = `Biztos vagy benne, hogy törlöd <strong>${productName}</strong>?`

            }

            // Function to handle deletion
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

            // Callback function for deletion failure
            function onDeleteFailure(error) {
                // Handle deletion failure, such as displaying an error message
                console.error(error.get_message());
            }
        </script>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</body>
</html>
