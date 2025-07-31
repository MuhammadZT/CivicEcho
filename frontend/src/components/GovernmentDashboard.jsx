import React, { useState } from 'react';
import '../style/governmentdashboard.css'; // Include shared dashboard CSS styles

const GovernmentDashboard = () => {
    // Static data for complaints (this can be replaced with an API call)
    const complaints = [
        {
            id: 1,
            description: 'Street lights are not working in my area.',
            category: 'Public Infrastructure',
            solution: '',
        },
        {
            id: 2,
            description: 'Garbage collection is irregular in the locality.',
            category: 'Waste Management',
            solution: '',
        },
        {
            id: 3,
            description: 'Traffic congestion is becoming a major issue in the city center.',
            category: 'Traffic and Transport',
            solution: '',
        },
    ];

    // State for showing solution form
    const [showSolutionForm, setShowSolutionForm] = useState(null); // Track which complaint is being edited
    const [solutionText, setSolutionText] = useState('');
    const [solutionFile, setSolutionFile] = useState(null);

    // Handle solution text and file input changes
    const handleSolutionChange = (e) => {
        setSolutionText(e.target.value);
    };

    const handleFileChange = (e) => {
        setSolutionFile(e.target.files[0]);
    };

    // Handle the submission of the solution
    const handleSolutionSubmit = (complaintId) => {
        // Here, you can handle solution submission logic (e.g., sending to backend)
        console.log('Solution for complaint ID', complaintId, {
            solutionText,
            solutionFile,
        });

        // Reset the solution form
        setSolutionText('');
        setSolutionFile(null);
        setShowSolutionForm(null);
    };

    return (
        <div className="dashboard">
            <div className="background-shape"></div>

            <div className="dashboard-container">
                <h2>Welcome, Government Official</h2>
                <div className="profile-section">
                    <h3>Complaint List</h3>

                    {/* Complaint List */}
                    <div className="complaint-list">
                        {complaints.map((complaint) => (
                            <div key={complaint.id} className="complaint-item">
                                <p><strong>Complaint:</strong> {complaint.description}</p>
                                <p><strong>Category:</strong> {complaint.category}</p>

                                {/* If the solution form is visible for this complaint, show it */}
                                {showSolutionForm === complaint.id ? (
                                    <div className="solution-form">
                                        <textarea
                                            value={solutionText}
                                            onChange={handleSolutionChange}
                                            placeholder="Enter solution here..."
                                        />
                                        <input type="file" onChange={handleFileChange} />
                                        <button
                                            className="submit-solution-btn"
                                            onClick={() => handleSolutionSubmit(complaint.id)}
                                        >
                                            Submit Solution
                                        </button>
                                    </div>
                                ) : (
                                    <button
                                        className="add-solution-btn"
                                        onClick={() => setShowSolutionForm(complaint.id)}
                                    >
                                        Add Solution
                                    </button>
                                )}
                            </div>
                        ))}
                    </div>
                </div>

                <div className="footer-text">
                    <p>Need help? <a href="/help">Contact Support</a></p>
                </div>
            </div>
        </div>
    );
};

export default GovernmentDashboard;
