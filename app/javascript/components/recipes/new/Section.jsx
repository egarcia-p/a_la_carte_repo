import React, { useState } from "react";
import Step from "./Step";
import PropTypes from "prop-types";

const SectionNameInput = (props) => {
  return (
    <input
      type="text"
      name="name"
      value={props.name}
      className="form-control"
      required
      onChange={props.updateValue}
    />
  );
};



const Section = (props) => {
  const section = props.section;
  const setSections = props.setSections;
  //const sections = props.sections;
  //const nameRef = useRef();
  const [name, setName] = useState(section.name);

  /*Event Handlers */
  const AddStepButton = () => {
    return <button onClick={onNewStepClick}>Add a new step</button>;
  };

  function onNewStepClick() {
    const newStep = {
      description: "Fill Description",
      step_number: section.steps.length + 1,
    };

    setSections(
      props.sections.map((current) => {
        if (current.id !== section.id) return current;
        return { ...current, steps: [...current.steps, newStep] };
      })
    );
  }

  const updateValue = (e) => {
    const value = e.target.value;
    setName(value);
    //nameRef.current.defaultValue = value;
    const sectionsCopy = [...props.sections]; // Get a copy of the sections array
    console.log(sectionsCopy);
    // Replace the current section item
    const indexToReplace = sectionsCopy.findIndex(object => {
      return object.id === section.id; //TODO fix for new sections, how does that work?
    });
    console.log(indexToReplace);
    sectionsCopy.splice(indexToReplace, 1, {
      id: section.id,
      index: section.index,
      name: value,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      steps: section.steps,
      
    });
    
    // Update the parent state
    setSections(sectionsCopy);
  };

 

  return (
    <div className="section">
      <h1>
        Section Name: <SectionNameInput name={name} updateValue={updateValue} />
      </h1>
      <h2>Section Id: {section.id}</h2>

      <AddStepButton />
      <div className="steps">
        {section.steps.map((step, index) => (
          <Step key={index} step={step} section={section} sections={props.sections} setSections={setSections}></Step>
        ))}
      </div>
    </div>
  );
};

Section.propTypes = {
  section: PropTypes.object,
  sections: PropTypes.array,
  setSections: PropTypes.func,
  key: PropTypes.number,
};

SectionNameInput.propTypes = {
  name: PropTypes.string,
  updateValue: PropTypes.func,
}

export default Section;
