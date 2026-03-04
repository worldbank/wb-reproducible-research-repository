---
layout: default
title: "World Bank Reproducible Research Repository Resources"
---

<header style="text-align: center; padding: 20px;">
  <h1>Welcome to the World Bank Reproducible Research Repository Resources</h1>
  <p>This site provides guidelines and resources for authors, reviewers, and users to ensure the reproducibility of research outputs.</p>
</header>

<style>
  /* General Navigation Styles */
  nav {
    text-align: center;
    margin: 20px 0;
    border-bottom: 1px solid #ddd;
    padding-bottom: 20px;
  }
  nav a {
    margin: 0 15px;
    color: #0366d6;
    text-decoration: none;
    font-weight: 500;
  }
  /* Dropdown Container */
  .dropdown {
    position: relative;
    display: inline-block;
  }
  /* Dropdown Content (Hidden by Default) */
  .dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    border: 1px solid #ccc;
    min-width: 260px; /* Adjusted for longer text */
    text-align: left;
    z-index: 1000;
    box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
  }
  /* Links inside the dropdown */
  .dropdown-content a {
    display: block;
    padding: 12px 16px;
  }
  /* Show the dropdown menu on hover */
  .dropdown:hover .dropdown-content {
    display: block;
  }

  /* New Card Layout Styles */
  .card-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    max-width: 900px;
    margin: 40px auto;
  }
  .card {
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    width: 250px;
    padding: 20px;
    text-align: center;
    transition: transform 0.2s;
  }
  .card:hover {
    transform: translateY(-5px);
  }
  .card h3 {
    margin-top: 0;
  }
  .card a {
    text-decoration: none;
    color: inherit;
  }
</style>

<!-- UPDATED NAVIGATION BAR -->
<nav>
  <!-- 1. Guidance -->
  <div class="dropdown">
    <a href="./guidance_note_wb.html">Guidance ▾</a>
    <div class="dropdown-content">
      <a href="./guidance_note_wb.html">📘 Full Guidance Note for Authors</a>
      <a href="./guidance/step_by_step_flagships.html">📋 Step-by-Step – For Flagships</a>
      <a href="./guidance/Excel_Guidelines.html"> 📈 Excel Guidelines </a>
    </div>
  </div> |
  
  <!-- 2. Checklist -->
  <a href="./reproducibility_package_checklist.html">Checklist</a> |
  
  <!-- 3. FAQs -->
  <a href="./reproducibility_FAQs.html">FAQs</a> |
  
  <!-- 4. Resources -->
  <a href="./resources.html">Resources</a> |
  
  <!-- 5. README -->
  <div class="dropdown">
    <a href="./README_resources.html">README ▾</a>
    <div class="dropdown-content">
      <a href="https://dime-worldbank.github.io/wb-reproducible-research-repository-automation/" target="_blank">▶️ README Automation Tool</a>
      <a href="https://github.com/worldbank/wb-reproducible-research-repository/raw/refs/heads/main/resources/README_Template.docx" target="_blank">📄 README Template (.docx)</a>
      <a href="https://github.com/worldbank/wb-reproducible-research-repository/blob/main/resources/README_Template.md" target="_blank">📝 README Template (.md)</a>
    </div>
  </div> |

  <!-- 6. Protocols -->
  <div class="dropdown">
    <a href="./reproducibility_reviewer_protocol.html">Protocols ▾</a>
    <div class="dropdown-content">
      <a href="./reproducibility_reviewer_protocol.html">🔎 Full Reviewer Protocol</a>
      <a href="./guidance/virtual_reproducibility_verification_protocol.html">💻 Virtual Verification Protocol</a>
    </div>
  </div> |

  <!-- 7. Trainings -->
  <a href="./reproducible_research_trainings.html">Trainings</a>

</nav>

<!-- UPDATED SECTIONS OVERVIEW WITH CARDS -->
<section>
  <div class="card-container">

    <!-- 1. Guidance -->
    <div class="card">
      <a href="./guidance_note_wb.html">
        <h3>Guidance for Authors</h3>
        <p>Detailed instructions for preparing a reproducible publication.</p>
      </a>
    </div>

    <!-- 2. Checklist -->
    <div class="card">
      <a href="./reproducibility_package_checklist.html">
        <h3>Checklist</h3>
        <p>A step-by-step guide to ensure all components are included.</p>
      </a>
    </div>

    <!-- 3. FAQs -->
    <div class="card">
      <a href="./reproducibility_FAQs.html">
        <h3>FAQs</h3>
        <p>Frequently asked questions about reproducibility packages.</p>
      </a>
    </div>

    <!-- 4. Resources -->
    <div class="card">
      <a href="./resources.html">
        <h3>Resources</h3>
        <p>Tools, templates, and other assets to support your research.</p>
      </a>
    </div>
    
    <!-- 5. README -->
    <div class="card">
      <a href="./README_resources.html">
        <h3>README Generator</h3>
        <p>Templates and generator tool to create a high-quality README file.</p>
      </a>
    </div>

    <!-- 6. Protocols -->
    <div class="card">
      <a href="./reproducibility_reviewer_protocol.html">
        <h3>Review Protocols</h3>
        <p>Evaluation guidelines for assessing the reproducibility of research.</p>
      </a>
    </div>

  </div>
</section>


<footer style="text-align: center; padding: 20px; border-top: 1px solid #ddd; margin-top: 20px;">
  <p><strong>Tools developed and maintained by 
    <a href="https://www.worldbank.org/en/about/unit/unit-dec/impactevaluation/dime-analytics" target="\_blank">DECDI Analytics</a></strong></p>
  <p>DIME Analytics creates open-source resources and solutions to ensure high-quality, reproducible research for the global development research community.</p>
</footer>

