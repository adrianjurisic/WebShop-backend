# Project Requirements: Application for Selling Electronic Goods

**As** a store administrator,  
**I want** to manage categories, products, attributes, photos, and orders,  
**so that** I can enable visitors and users to efficiently browse and order products.  

**As** an application visitor,  
**I want** to browse and search products by categories and attributes,  
**so that** I can find the desired products and potentially create a user account for placing orders.

**As** a logged-in user,  
**I want** to manage my user account and orders,  
**so that** I can have easier access to previous purchases and update my information.

## Functional Requirements:

### Categories and Attributes
- [ ] Each category must have a unique name and an image representing the type of products in that category.
- [ ] Categories can have an unlimited number of subcategories.
- [ ] Categories define the attributes that the products in that category can have.
- [ ] Attributes are also used as search parameters for products.

### Products
- [ ] Products belong to only one category.
- [ ] Products have a name, a short description, a detailed description, and one or more photos.
- [ ] Products have values for one or more attributes of the category they belong to.
- [ ] A history of product price changes must be maintained, and the latest price should be displayed on the web application.
- [ ] Withdrawn products are not visible in categories or search results, and their details page redirects users to the product listing of the category they belonged to.

### Homepage
- [ ] Display promoted products.
- [ ] Display the newest products added to the store.

### Visitors
- [ ] Can browse products by categories and search for products by attributes within a selected category.
- [ ] Can register a user account with mandatory personal information, contact details, residential address, and desired login credentials.
- [ ] Email addresses must be unique during registration.

### Logged-in Users
- [ ] Can add products to the cart, change quantities, or remove items from the cart.
- [ ] Can order products from the cart.
- [ ] Can view and update user account details.
- [ ] Have access to a list of previous orders and their statuses.
- [ ] Can change the account password.

### Administrators
- [ ] Can manage categories, attributes, products, and photos.
- [ ] Can view orders, change their status (rejected, accepted, fulfilled), and review customer details.

## Technical Constraints:
- [ ] Use a relational database following the previously adopted naming conventions.
- [ ] The application must be developed on the Node.js platform, adhering to the MVC architecture.
- [ ] The graphical user interface must be responsive and adapt to various devices.
- [ ] Application code versioning must be managed via a Git repository.
- [ ] Apply best practices for web application development.

#### Notes:
- Input validation must be implemented where applicable.
- Ensure the security of user data and authentication processes.
