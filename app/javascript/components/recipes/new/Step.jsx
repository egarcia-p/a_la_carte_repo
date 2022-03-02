import React, { useState } from "react";
import PropTypes from "prop-types";

const Step = (props) => {
  const step = props.step;
  const section = props.section;
  const setSections = props.setSections;
  const [stepNumber, setStepNumber] = useState(step.step_number);
  //const [description, setDescription] = useState(step.description);

  const updateValueStepNumber = (e) => {
    const value = e.target.value;
    setStepNumber(value);
    const sectionsCopy = [...props.sections]; // Get a copy of the sections array
    const stepsCopy = [...section.steps];
    console.log(stepsCopy);
    const indexToReplaceStep = section.steps.findIndex((object) => {
      return object.step_number === step.step_number; //TODO check if this works when step is changed issue is that when steps are duplicate it changes both
    });
    stepsCopy.splice(indexToReplaceStep, 1, {
      id: step.id,
      recipe_id: step.recipe_id,
      section_id: step.section_id,
      step_number: value,
      description: step.description,
    });

    // Replace the current section item
    const indexToReplace = sectionsCopy.findIndex((object) => {
      return object.id === section.id; //TODO check how to work with mulitple new sections
    });
    console.log(indexToReplace);
    sectionsCopy.splice(indexToReplace, 1, {
      id: section.id,
      index: section.index,
      name: section.name,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      steps: stepsCopy,
    });

    // Update the parent state
    setSections(sectionsCopy);
  };

  //TODO Make steps editable
  return (
    <div className="step">
      <label htmlFor="stepNumber">Step #</label>
      <input
        type="text"
        name="step_number"
        value={stepNumber}
        id="stepNumber"
        className="form-control"
        required
        onChange={updateValueStepNumber}
      />
      <label htmlFor="stepDescription">Description</label>
      <textarea
        type="text"
        name="description"
        defaultValue="Type step description"
        value={step.description}
        id="stepDescription"
        className="form-control"
        required
        // onChange={updateValue}
      />
    </div>
  );
};

Step.propTypes = {
  step: PropTypes.object,
  section: PropTypes.object,
  sections: PropTypes.array,
  setSections: PropTypes.func,
};

export default Step;
