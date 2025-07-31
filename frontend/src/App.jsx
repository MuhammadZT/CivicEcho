// CivicEcho/frontend/src/App.jsx
import React, { useState, useEffect } from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Login from './components/Login';
import Register from './components/Register';
import CitizensDashboard from './components/CitizensDashboard';
import GovernmentDashboard from './components/GovernmentDashboard';


const App = () => {
  const [user, setUser] = useState(null);

  // Retrieve the user data from localStorage when the app loads
  useEffect(() => {
    const userData = JSON.parse(localStorage.getItem('user')); // Get stored user data
    setUser(userData); // Set the user state
  }, []);

  return (
    <div className="app-container">
      <Routes>
        {/* Redirect root to login */}
        <Route path="/" element={<Navigate to="/login" replace />} />

        {/* Login and Register Routes */}
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />

        {/* Protected dashboard routes */}
        <Route
          path="/citizens-dashboard"
          element={
            user && user.role === 'Citizen'
              ? <CitizensDashboard />
              : <Navigate to="/login" replace />
          }
        />
        <Route
          path="/government-dashboard"
          element={
            user && user.role === 'Government Official'
              ? <GovernmentDashboard />
              : <Navigate to="/login" replace />
          }
        />

        {/* Default route for 404 */}
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </div>
  );
};

export default App;
