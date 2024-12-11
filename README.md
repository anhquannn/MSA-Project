# MSA Project

## Project Overview
The MSA system will manage all aspects of customer interactions, employee actions, inventory, discounts, orders, and customer support. The system will be divided into two primary user groups: Employees and Customers, with separate functionalities to ensure seamless operations.

## Requirements

### For Staff
1. Login
Description: Staff can log in using the provided credentials.
Priority: High
Acceptance Criteria:
Staff can securely log in using their unique username and password.
Failed login attempts are tracked and logged.
2. Inventory Management
Description: Manage products in the inventory (add, update, and delete products).
Priority: High
Acceptance Criteria:
Staff can add new products to the inventory with details like name, description, price, quantity, etc.
Staff can update the product details such as pricing, description, and stock levels.
Staff can delete products that are no longer being sold or are out of stock.
Stock levels are updated automatically when products are added or removed.
3. Discount Code Management
Description: Create, update, and delete discount codes.
Priority: High
Acceptance Criteria:
Staff can create new discount codes with specified conditions (e.g., minimum order amount, percentage discount, expiry date).
Staff can modify the conditions for existing discount codes, such as the applicable dates and requirements.
Staff can delete discount codes that are no longer required.
4. Update Discount Conditions
Description: Modify conditions under which discount codes apply.
Priority: Medium
Acceptance Criteria:
Staff can update conditions like minimum order amounts, required quantity of items, and other restrictions associated with discount codes.
Changes are reflected immediately in the system for customer use.
5. Customer Management
Description: View, search, and delete customer information.
Priority: Medium
Acceptance Criteria:
Staff can search for customers based on various criteria such as name, email, or phone number.
Staff can view detailed customer profiles, including their order history, contact details, and preferences.
Staff can delete customers from the system when necessary.
6. Order Management
Description: Search, view, modify, and delete orders.
Priority: High
Acceptance Criteria:
Staff can search for orders using order IDs, customer names, or product names.
Staff can view the status of each order, including payment status, shipping status, and delivery updates.
Staff can modify order details (e.g., change shipping address or product quantities).
Staff can delete orders if necessary, especially for canceled or erroneous orders.

### For Customers
1. Registration and Login
Description: Allow users to register a new account or log in to an existing account.
Priority: High
Acceptance Criteria:
Customers can register by providing necessary details such as name, email, and password.
Customers can log in to their accounts using email and password.
Forgot password functionality to allow customers to reset their password via email.
Customers can manage their login credentials securely.
2. Personal Information Management
Description: Update personal details like name, shipping address, phone number, and payment methods.
Priority: Medium
Acceptance Criteria:
Customers can update their contact information, including name, email, and phone number.
Customers can add or edit shipping addresses and select the default address.
Customers can add, update, or remove payment methods linked to their account.
3. Product Search
Description: Search products by name, category, or price.
Priority: High
Acceptance Criteria:
Customers can search for products based on various filters, such as product name, category, and price range.
The search results are displayed with product names, images, and basic details.
4. Cart Management
Description: Add products to the cart, update quantities, and proceed to checkout.
Priority: High
Acceptance Criteria:
Customers can add products to their cart with specific quantities.
Customers can edit product quantities or remove items from their cart.
The cart is saved and accessible at any time for future purchases.
5. Discount Code Usage
Description: Apply discount codes during checkout and verify their eligibility.
Priority: Medium
Acceptance Criteria:
Customers can enter discount codes during checkout.
The system verifies whether the discount code is valid based on conditions like order amount, expiration date, and product restrictions.
The discount is applied, and the new total price is displayed before payment.
6. Placing Orders
Description: Finalize purchases by selecting products from the cart and providing payment and shipping information.
Priority: High
Acceptance Criteria:
Customers can review their order details before placing an order.
Customers select a payment method (e.g., credit card, PayPal, cash on delivery).
Customers provide shipping information, including the delivery address and preferred shipping method.
The system processes the order and confirms the purchase.
7. Support Requests
Description: Customers can send support requests to the customer service team.
Priority: Medium
Acceptance Criteria:
Customers can create support tickets for issues related to orders, products, or accounts.
The system tracks the status of support tickets (open, resolved, closed).
8. Payment
Description: Complete transactions using third-party payment methods or cash on delivery.
Priority: High
Acceptance Criteria:
Customers can complete payments using integrated payment methods (e.g., credit/debit cards, e-wallets).
The system confirms payment and updates the order status accordingly.
Cash on delivery is supported as a payment option.
9. Product Ratings and Reviews
Description: Customers can rate and review products after completing an order.
Priority: Medium
Acceptance Criteria:
Customers can provide ratings (e.g., stars) and write reviews for products they have purchased.
The system displays ratings and reviews for products to help future customers make informed decisions.
10. Shipping Method Selection
Description: Choose a preferred shipping method based on cost and delivery time.
Priority: Medium
Acceptance Criteria:
Customers can select a shipping method from available options (e.g., standard, express, or pickup).
Shipping cost and estimated delivery time are displayed before checkout.
---
This README provides a detailed overview of the requirements and priorities for the MSA project.
