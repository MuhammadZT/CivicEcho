import React, { useState } from 'react';
import '../style/citizendashboard.css'; 

const CitizensDashboard = () => {
    // State for complaint form fields
    const [description, setDescription] = useState('');
    const [category, setCategory] = useState('');
    const [attachment, setAttachment] = useState(null);
    const [notificationsWidth, setNotificationsWidth] = useState(300); // Default width of the notification bar

    // Complaint categories
    const categories = [
        'Public Infrastructure',
        'Waste Management',
        'Traffic and Transport',
        'Health and Safety',
        'Environment and Pollution',
        'Education',
        'Law and Order',
        'Utilities',
        'Corruption and Governance',
        'Housing and Urban Development',
    ];

    // Handle complaint form submission
    const handleSubmit = async (e) => {
        e.preventDefault();
        // Handle form submission logic (e.g., send data to backend API)
        console.log('Complaint submitted:', { description, category, attachment });
    };

    // Handle notification bar resizing
    const handleResize = (e) => {
        const newWidth = e.clientX;
        if (newWidth > 100 && newWidth < 600) { // Limits for the notifications bar width
            setNotificationsWidth(newWidth);
        }
    };

    return (
        <div className="dashboard">
            <div className="background-shape"></div>

            <div className="dashboard-container">
                <h2>Welcome to the Citizen Dashboard</h2>

                <div className="complaint-form">
                    <h3>Submit a New Complaint</h3>
                    <form onSubmit={handleSubmit}>
                        <div className="form-group">
                            <label htmlFor="category">Category</label>
                            <select
                                id="category"
                                value={category}
                                onChange={(e) => setCategory(e.target.value)}
                                required
                            >
                                <option value="">Select Category</option>
                                {categories.map((cat, index) => (
                                    <option key={index} value={cat}>
                                        {cat}
                                    </option>
                                ))}
                            </select>
                        </div>

                        <div className="form-group">
                            <label htmlFor="description">Description</label>
                            <textarea
                                id="description"
                                placeholder="Describe your complaint..."
                                value={description}
                                onChange={(e) => setDescription(e.target.value)}
                                required
                            />
                        </div>

                        <div className="form-group">
                            <label htmlFor="attachment">Attachment</label>
                            <input
                                type="file"
                                id="attachment"
                                onChange={(e) => setAttachment(e.target.files[0])}
                            />
                        </div>

                        <button type="submit" className="dashboard-btn">Submit Complaint</button>
                    </form>
                </div>
            </div>

            {/* Notifications bar */}
            <div
                className="notifications-bar"
                style={{ width: `${notificationsWidth}px` }}
                onMouseDown={(e) => { document.onmousemove = handleResize; document.onmouseup = () => { document.onmousemove = null; document.onmouseup = null; } }}
            >
                <h4>Notifications</h4>
                {/* Placeholder for notifications content */}
                <div className="notification-item">New complaint submitted</div>
                <div className="notification-item">Your complaint has been reviewed</div>
            </div>
        </div>
    );
};

export default CitizensDashboard;
