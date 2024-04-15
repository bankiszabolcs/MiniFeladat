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
        <asp:HiddenField ID="hfProductName" runat="server" />
        <asp:HiddenField ID="hfProductPrice" runat="server" />
        <asp:HiddenField ID="hfProductStockQuantity" runat="server" />
        <asp:HiddenField ID="hfProductDescription" runat="server" />
        <asp:HiddenField ID="hfProductCategory" runat="server" />
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">MiniFeladat</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Főoldal
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Termékek</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Kapcsolat
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Kapcsolat 1</a></li>
                                <li><a class="dropdown-item" href="#">Kapcsolat 2</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="#">GYIK</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link disabled" aria-disabled="true">Házhozszállítás</a>
                        </li>
                    </ul>
                    <form class="d-flex" role="search">
                        <input class="form-control me-2" type="search" placeholder="Keresés a termékeink között" aria-label="Search">
                        <button class="btn btn-outline-success" type="submit">Keresés</button>
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
                                <th class="text-center" scope="col">Termék ID</th>
                                <th class="text-center" scope="col">Név</th>
                                <th class="text-center" scope="col">Ár</th>
                                <th class="text-center" scope="col">Mennyiség</th>
                                <th class="text-center" scope="col">Leírás</th>
                                <th class="text-center" scope="col">Kategória</th>
                                <th class="text-center" scope="col">Elérhető</th>
                                <th class="text-center" scope="col">
                                    <button type="button" class="btn btn-success" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: 2rem; --bs-btn-font-size: .75rem;" data-bs-toggle="modal" data-bs-target="#editModal" onclick="showEditModal()">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var product in ProductList)
                                { %>
                            <tr id="productRow_<%: product.ProductId %>">
                                <td class="text-center align-middle"><%: product.ProductId %></td>
                                <td class="text-center align-middle"><%: product.Name %></td>
                                <td class="text-center align-middle"><%: product.Price.ToString().Replace(",",".") %> Ft</td>
                                <td class="text-center align-middle"><%: product.StockQuantity %> db</td>
                                <td class="text-center align-middle"><%: product.Description %></td>
                                <td class="text-center align-middle"><%: product.Category %></td>
                                <td class="text-center text-muted align-middle"><% if (product.IsAvailable)
                                                                                    { %>
                                    <i class="fa fa-check"></i>
                                    <% }
                                        else
                                        { %>
                                    <i class="fa fa-times"></i>
                                    <% } %></td>
                                <td class="align-middle">
                                    <div class="d-flex justify-content-center column-gap-2">
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal" onclick="showEditModal(<%: product.ProductId %>, '<%: product.Name %>', '<%:product.Price.ToString().Replace(",",".") %>', <%:product.StockQuantity %>, '<%:product.Description %>', '<%:product.Category %>', <%: (product.IsAvailable ? "true" : "false") %>)">
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
                        Biztosan törlöd ezt az elemet??
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Mégsem</button>
                        <button type="button" class="btn btn-danger" onclick="deleteItem()" data-bs-dismiss="modal">Törlés</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="editModal" class="modal fade" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Termék szerkesztése</h4>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="editForm">
                            <div class="mb-3">
                                <label for="editProductName" class="form-label">Név:</label>
                                <input type="text" class="form-control" id="editProductName" />
                                <div class="invalid-feedback">
                                    Termék nevének legalább 3 katakterből kell állnia
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editProductPrice" class="form-label">Ár:</label>
                                <input type="number" class="form-control" id="editProductPrice" />
                                <div class="invalid-feedback">
                                    Az ár nem lehet negatív!
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editProductStockQuantity" class="form-label">Mennyiség:</label>
                                <input type="number" class="form-control" id="editProductStockQuantity" />
                                <div class="invalid-feedback">
                                    A raktármennyiség nem lehet negatív!
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editProductDescription" class="form-label">Leírás:</label>
                                <textarea class="form-control" id="editProductDescription"></textarea>
                                <div class="invalid-feedback">
                                    A raktármennyiség nem lehet negatív.
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="editProductCategory" class="form-label">Kategória:</label>
                                <select class="form-select" id="editProductCategory">
                                    <option disabled selected>-Kategóriák-</option>
                                    <% foreach (var category in Categories)
                                        { %>
                                    <option value="<%= category.Name %>"><%= category.Name %></option>
                                    <% } %>
                                </select>
                                <div class="invalid-feedback">Válassz kategóriát!</div>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="editIsAvailable" />
                                <label class="form-check-label" for="editIsAvailable">Raktáron</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Mégse</button>
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="updateProduct()">Mentés</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="toast align-items-center text-white border-0 position-absolute mb-3 bottom-0 start-50 translate-middle-x" style="" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    Termék sikeresen hozzáadva!
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
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
                    openToast("Sikeres törlés!", "green")
                }
            }

            function onDeleteFailure(error) {
                console.error(error.get_message());
                openToast("Sikertelen törlés", "red")
            }

            function showEditModal(id = 0, name = "", price = 0, stockQuantity = 0, description = "", category = "", isAvailable = false) {

                document.getElementById('<%= hfProductId.ClientID %>').value = id;

                document.getElementById('editProductName').value = name;
                document.getElementById('editProductPrice').value = price;
                document.getElementById('editProductStockQuantity').value = stockQuantity;
                document.getElementById('editProductDescription').value = description;

                var categorySelect = document.getElementById('editProductCategory');
                if (category === "") {
                    categorySelect.value = "-Kategóriák-";
                } else {
                    categorySelect.value = category;
                }

                document.getElementById('editIsAvailable').checked = isAvailable;
            }

            function updateProduct() {

                const productId = document.getElementById('<%= hfProductId.ClientID %>').value;
                const name = document.getElementById('editProductName').value;
                const priceString = document.getElementById('editProductPrice').value;
                const price = parseFloat(priceString).toFixed(2);
                const stockQuantity = document.getElementById('editProductStockQuantity').value;
                const description = document.getElementById('editProductDescription').value;
                const category = document.getElementById('editProductCategory').value;
                const isAvailable = document.getElementById('editIsAvailable').checked;

                try {
                    if (productId == 0) {
                        PageMethods.AddProduct(name, price, stockQuantity, description, category, isAvailable, onUpdateSuccess, onUpdateFailure);
                    } else {
                        PageMethods.UpdateProduct(productId, name, price, stockQuantity, description, category, isAvailable, onUpdateSuccess, onUpdateFailure);
                    }
                } catch (e) {
                    console.log(e)
                    openToast(`Sikertelen mentés. ${e}`, "red")
                }

            }

            function onUpdateSuccess(res) {
                if (!res.success) {
                    openToast(res.message, "red")
                    return 
                }
                let product = res.data;
                var row = document.getElementById('productRow_' + product.ProductId);
                if (!row) {
                    var tr = document.createElement("tr");
                    tr.id = "productRow_" + product.ProductId;
                    var tbody = document.querySelector("tbody");
                    tbody.appendChild(tr);
                    row = tr
                }
                row.innerHTML = "";
                row.innerHTML = `
            <td class="text-center align-middle">${product.ProductId}</td>
            <td class="text-center align-middle">${product.Name}</td>
            <td class="text-center align-middle">${product.Price} Ft</td>
            <td class="text-center align-middle">${product.StockQuantity} db</td>
            <td class="text-center align-middle">${product.Description}</td>
            <td class="text-center align-middle">${product.Category}</td>
             <td class="text-center text-muted align-middle">${product.IsAvailable ? '<i class="fa fa-check"></i>'
                        :
                        '<i class="fa fa-times"></i>'}</td>
            <td class="align-middle">
                <div class="d-flex justify-content-center column-gap-2">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal" onclick="showEditModal(${product.ProductId}, '${product.Name}', ${product.Price}, ${product.StockQuantity}, '${product.Description}', '${product.Category}', ${(product.IsAvailable ? "true" : "false")})">
                        <i class="fa fa-edit"></i>
                    </button>
                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="showDeleteModal(${product.ProductId}, '${product.Name}')">
                        <i class="fa fa-trash"></i>
                    </button>
                </div>
            </td>;`

                openToast("Sikeres mentés", "green")
                

            }

            function onUpdateFailure(error) {
                console.error(error.get_message());
                openToast("Sikertelen mentés.", "red")
            }

            function openToast(text, color) {
                
                let toastEl = document.querySelector('.toast');
                let toastBody = toastEl.querySelector('.toast-body')

                toastBody.innerText = text;

                if (color === "red") {
                    toastEl.classList.add('bg-danger')
                    toastEl.classList.remove('bg-success')
                } else if (color === "green") {
                    toastEl.classList.remove('bg-danger')
                    toastEl.classList.add('bg-success')
                }

                let toast = new bootstrap.Toast(toastEl);
                
                toast.show();

                setTimeout(function () {
                    toast.hide();
                }, 2000);
            }

            const checkNegativeOrNot = function () {
                var inputField = this.value;
                var min = 0;

                if (inputField.length === 0) {
                    this.classList.add('is-invalid');
                    this.nextElementSibling.innerText = "Mező nem lehet üres";
                }
                else if (inputField < min) {
                    this.classList.add('is-invalid');
                    this.nextElementSibling.innerText = "Az érték nem lehet negatív!";
                } else {
                    this.classList.remove('is-invalid');
                }
            }

            const checkTheName = function () {
                const inputField = this.value;
                const min = 3;

                if (inputField.length === 0) {
                    this.classList.add('is-invalid');
                    this.nextElementSibling.innerText = "Mező nem lehet üres";
                }
                else if (inputField.length < min) {
                    this.classList.add('is-invalid');
                    this.nextElementSibling.innerText = "Névnek legalább 3 karakterből kell állnia";
                } else {
                    this.classList.remove('is-invalid');
                }
            }

            const checkTheDescription = function () {
                var inputField = this.value;
                var min = 0;

                if (inputField.length === 0) {
                    this.classList.add('is-invalid');
                    this.nextElementSibling.innerText = "Mező nem lehet üres";
                } else {
                    this.classList.remove('is-invalid');
                }
            }

            const checkTheCategory = function (e) {
                if (e.target.value === "-Kategóriák-") {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.remove('is-invalid');
                }
            }

            document.querySelector('#editProductPrice').addEventListener('input', checkNegativeOrNot)
            document.querySelector('#editProductStockQuantity').addEventListener('input', checkNegativeOrNot)
            document.querySelector('#editProductName').addEventListener('input', checkTheName)
            document.querySelector('#editProductDescription').addEventListener('input', checkTheDescription)
            document.querySelector('#editProductCategory').addEventListener('click', checkTheCategory)

        </script>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</body>
</html>
