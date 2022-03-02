import React, { useState, useEffect } from "react";
import { useHistory, useParams } from "react-router-dom";
import Section from "./Section";

// stripHtmlEntities(str) {
//   return String(str).replace(/</g, "&lt;").replace(/>/g, "&gt;");
// }

// onChange(event) {
//   this.setState({ [event.target.name]: event.target.value });
// }

function RecipeSteps(props) {
  let params = useParams();
  const history = useHistory();
  const [sections, setSections] = useState([
    //Example of json state for sections
    // {
    //   index: 1,
    //   id: 1,
    //   name: "Section Test 1",
    //   steps: [{ description: "Desc step 1", step_number: 1 }],
    // },
    // {
    //   index: 2,
    //   id: 2,
    //   name: "Section Test 1",
    //   steps: [],
    // },
  ]);

  useEffect(() => {
    Promise.all([
      // fetch(`/api/v1/recipe/edit/${props.recipe_id}`),
      fetch(`/api/v1/sections/find_by_recipe_id/${params.id}`),
    ])
      .then(([res1]) => {
        return Promise.all([res1.json()]);
      })
      .then(([res1]) => {
        console.log(res1);
        setSections(res1);
      });
  }, []);

  /*Event Handlers */
  const AddSectionButton = () => {
    return <button onClick={onNewSectionClick}>Add a new section</button>;
  };

  function onNewSectionClick() {
    const newSection = {
      index: sections.length + 1,
      id: "",
      name: "Insert Name",
      steps: [],
    };
    setSections([...sections, newSection]);
  }

  function onSubmit(e) {
    e.preventDefault();
    

    var target = { targetrecord: sections };
    console.log({
      target,
    });

    const url = `/api/v1/sections/save_multiple`;

    const token = `$('meta[name="csrf-token"]').attr('content')`;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(target),
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => {
        history.push({
          pathname: "/recipes",
        });
      })
      .catch((error) => console.log(error.message));
  }

  return (
    <div className="container mt-5">
      <div className="row">
        <div className="col-sm-12 col-lg-6 offset-lg-3">
          <h1 className="font-weight-normal mb-5">
            Add Sections and Steps for Recipe: {params.id}
          </h1>
          <AddSectionButton />
          <form onSubmit={onSubmit}>
            {sections.map((section, index) => (
              <Section
                key={index}
                section={section}
                sections={sections}
                setSections={setSections}
              ></Section>
            ))}

            <button type="submit">Save form</button>
          </form>
        </div>
      </div>
    </div>
  );
}

export default RecipeSteps;