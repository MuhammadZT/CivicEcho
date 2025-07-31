import React, { useState } from 'react';
import axios from 'axios';
import '../style/register.css';

const Register = () => {
  const [nid, setNid] = useState('');
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [contact, setContact] = useState('');
  const [password, setPassword] = useState('');

  // New state for location dropdowns
  const [selectedDistrict, setSelectedDistrict] = useState('');
  const [selectedUpazila, setSelectedUpazila] = useState('');

  // Location data for Division, District, and Upazila
  const locations = {
    Dhaka: {
      districts: [
        { name: 'Dhaka', upazilas: ['Dhanmondi', 'Mirpur', 'Gulshan', 'Khilgaon', 'Badda', 'Mohakhali', 'Tejgaon', 'Puranapara'] },
        { name: 'Gazipur', upazilas: ['Tongi', 'Kaliakair', 'Sreepur', 'Kapasia'] },
        { name: 'Narayanganj', upazilas: ['Narayanganj Sadar', 'Rupganj', 'Sonargaon'] },
        { name: 'Mymensingh', upazilas: ['Mymensingh Sadar', 'Trishal', 'Ishwarganj', 'Haluaghat', 'Gouripur'] },
        { name: 'Tangail', upazilas: ['Tangail Sadar', 'Gopalpur', 'Kalihati', 'Nagarpur'] },
        { name: 'Kishoreganj', upazilas: ['Kishoreganj Sadar', 'Mithamain', 'Bajitpur', 'Karimganj'] },
        { name: 'Moulvibazar', upazilas: ['Moulvibazar Sadar', 'Kulaura', 'Barlekha', 'Juri'] },
        { name: 'Faridpur', upazilas: ['Faridpur Sadar', 'Nagarkanda', 'Boalmari', 'Madhukhali'] },
        { name: 'Munshiganj', upazilas: ['Munshiganj Sadar', 'Sreenagar'] },
        { name: 'Madaripur', upazilas: ['Madaripur Sadar', 'Shibchar'] },
        { name: 'Shariatpur', upazilas: ['Shariatpur Sadar', 'Bhedarganj'] },
        { name: 'Rajbari', upazilas: ['Rajbari Sadar', 'Pangsha', 'Goalanda'] },
        { name: 'Manikganj', upazilas: ['Manikganj Sadar', 'Shibalaya', 'Daulatpur'] },
        { name: 'Narsingdi', upazilas: ['Narsingdi Sadar', 'Raipura', 'Belabo', 'Monohardi'] }
      ]
    }
  };

  // Handle changes in District dropdown
  const handleDistrictChange = (event) => {
    setSelectedDistrict(event.target.value);
    setSelectedUpazila(''); // Reset Upazila when District changes
  };

  // Handle form submission
const handleSubmit = async (e) => {
    e.preventDefault();

    const data = {
      nid,
      name,
      email,
      contact,
      password,
      role: 'Citizen',
      location: { division: 'Dhaka', district: selectedDistrict, upazila: selectedUpazila }
    };

    try {
      const response = await axios.post('http://localhost:8000/backend/register.php', data);

      if (response.data.success) {
        alert('Registration successful. Please login!');
        window.location.href = '/login'; // Redirect to login page after successful registration
      } else {
        alert(response.data.message); // Show backend message
      }
    } catch (error) {
      console.error('Error during registration:', error);
      alert('There was an error with the registration.');
    }
};

  return (
    <div className="register-page">
      <div className="background-shape"></div>

      <div className="register-container animate-slide-up">
        <h2>Create Account</h2>
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
            <label htmlFor="name">Full Name</label>
            <input
              type="text"
              id="name"
              name="name"
              placeholder="Name"
              required
              value={name}
              onChange={(e) => setName(e.target.value)}
            />
          </div>

          <div className="form-group">
            <label htmlFor="email">Email Address</label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </div>

          <div className="form-group">
            <label htmlFor="contact">Contact Number</label>
            <input
              type="text"
              id="contact"
              name="contact"
              placeholder="+8801XXXXXXXXX"
              required
              value={contact}
              onChange={(e) => setContact(e.target.value)}
            />
          </div>

          <div className="form-group">
            <label htmlFor="password">Create Password</label>
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
            <label htmlFor="district">District</label>
            <select id="district" value={selectedDistrict} onChange={handleDistrictChange} required>
              <option value="">Select District</option>
              {locations.Dhaka.districts.map((district) => (
                <option key={district.name} value={district.name}>
                  {district.name}
                </option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label htmlFor="upazila">Upazila</label>
            <select
              id="upazila"
              value={selectedUpazila}
              onChange={(e) => setSelectedUpazila(e.target.value)}
              required
            >
              <option value="">Select Upazila</option>
              {selectedDistrict &&
                locations.Dhaka.districts
                  .find((district) => district.name === selectedDistrict)
                  .upazilas.map((upazila) => (
                    <option key={upazila} value={upazila}>
                      {upazila}
                    </option>
                  ))}
            </select>
          </div>

          <button type="submit" className="register-btn">
            Register Here
          </button>
        </form>

        <div className="footer-text">
          Already have an account? <a href="/login">Login here</a>
        </div>
      </div>
    </div>
  );
};

export default Register;
