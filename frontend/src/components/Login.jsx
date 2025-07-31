// frontend/src/components/Login.jsx
import React, { useState } from 'react';
import axios from 'axios';
import '../style/login.css';
import { useNavigate } from 'react-router-dom';

const Login = () => {
    const [nid, setNid] = useState('');
    const [password, setPassword] = useState('');
    const [role, setRole] = useState('Citizen');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);

        const data = { nid, password, role };

        try {
            const response = await axios.post('http://localhost:8000/backend/login.php', data);
            if (response.data.success) {
                // Store the user data in localStorage after successful login
                localStorage.setItem('user', JSON.stringify({
                    nid: nid,
                    role: role,
                    // Add other data you want to store (e.g., name, etc.)
                }));
                
                // Redirect based on role
                if (role === 'Citizen') {
                    navigate('/citizens-dashboard');
                } else {
                    navigate('/government-dashboard');
                }
            } else {
                alert('Invalid credentials. Please try again.');
            }
        } catch (error) {
            console.error('Error during login:', error);
            alert('There was an error logging in. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="login-page">
            <div className="background-shape"></div>

            <div className="login-container animate-slide-up">
                <h2>Login</h2>
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label htmlFor="nid">NID Number</label>
                        <input
                            type="text"
                            id="nid"
                            name="nid"
                            placeholder="NID"
                            required
                            value={nid}
                            onChange={(e) => setNid(e.target.value)}
                        />
                    </div>

                    <div className="form-group">
                        <label htmlFor="password">Password</label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Password"
                            required
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                        />
                    </div>

                    <div className="form-group">
                        <label>User Type</label>
                        <div className="role-slider">
                            <input
                                type="radio"
                                id="citizen"
                                name="role"
                                value="Citizen"
                                checked={role === 'Citizen'}
                                onChange={(e) => setRole(e.target.value)}
                            />
                            <input
                                type="radio"
                                id="official"
                                name="role"
                                value="Government Official"
                                checked={role === 'Government Official'}
                                onChange={(e) => setRole(e.target.value)}
                            />

                            <div className="slider two-options">
                                <label htmlFor="citizen">Citizen</label>
                                <label htmlFor="official">Government Official</label>
                                <div className="slide-bg"></div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" className="login-btn" disabled={loading}>
                        {loading ? 'Logging in...' : 'Login'}
                    </button>
                </form>

                <div className="footer-text">
                    Don't have an account?{' '}
                    <button onClick={() => navigate('/register')}>Create Account</button>
                </div>
            </div>
        </div>
    );
};

export default Login;
