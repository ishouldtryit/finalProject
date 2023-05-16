<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>
<head>
    <title>Employee List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Employee List</h2>
    <table>
        <thead>
            <tr>
                <th>Employee No</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Hire Date</th>
                <!-- Add more columns if needed -->
            </tr>
        </thead>
        <tbody>
            <!-- Iterate over the employees and populate the table rows -->
            <tr th:each="employee : ${employees}">
                <td th:text="${employee.empNo}"></td>
                <td th:text="${employee.empName}"></td>
                <td th:text="${employee.empEmail}"></td>
                <td th:text="${employee.empPhone}"></td>
                <td th:text="${employee.empAddress}"></td>
                <td th:text="${employee.empHireDate}"></td>
                <!-- Add more cells for additional employee properties -->
            </tr>
        </tbody>
    </table>
</body>
</html>
 