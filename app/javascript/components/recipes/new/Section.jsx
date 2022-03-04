import React, { useState } from "react";
//import Step from "./Step";
import PropTypes from "prop-types";
import Step from "./Step";

const SectionNameInput = (props) => {
  return (
    <input
      type="text"
      name="name"
      value={props.name}
      className="form-control"
      required
      onChange={props.updateName}
    />
  );
};



const Section = (props) => {
  const section = props.section;
  const sectionIndex = props.sectionIndex;
  const setSectionsMap = props.setSectionsMap;
  //const sections = props.sections;
  //const nameRef = useRef();
  const [name, setName] = useState(section.name);

  /*Event Handlers */
  const AddStepButton = () => {
    return <button onClick={onNewStepClick}>Add a new step</button>;
  };

  function onNewStepClick() {
    // const newStep = {
    //   description: "Fill Description",
    //   step_number: section.steps.length + 1,
    // };

    // setSectionsMap(
    //   props.sectionsMap.map((current) => {
    //     if (current.id !== section.id) return current;
    //     return { ...current, steps: [...current.steps, newStep] };
    //   })
    // );
  }

  const updateName = (e) => {
    const value = e.target.value;
    setName(value);

    const sectionsMapCopy = new Map(props.sectionsMap); // Get a copy of the sections array
    //console.log(sectionsMapCopy);
    // Replace the current section item
    // const indexToReplace = sectionsMapCopy.findIndex(object => {
    //   return object.id === section.id; //TODO fix for new sections, how does that work?
    // });

    const newSection = {
      id: section.id,
      index: section.index,
      name: value,
      recipe_id: section.recipe_id,
      sort_number: section.sort_number,
      steps: section.steps,
    }

    sectionsMapCopy.set(sectionIndex,newSection)
    
    // Update the parent state
    setSectionsMap(sectionsMapCopy);
  };

 console.log(section)

  return (
    <div className="section">
      <h2>Section Id: {section.id}</h2>
      <h1>
        Section Name: <SectionNameInput name={name} updateName={updateName} />
      </h1>
      

      <AddStepButton />
      <div className="steps">
        {section.steps.map((step, index) => (
          <Step key={index} step={step} section={section} sectionsMap={props.sectionsMap} setSectionsMap={setSectionsMap}></Step>
        ))}
      </div>
    </div>
  );
};

Section.propTypes = {
  section: PropTypes.object,
  sectionIndex: PropTypes.number,
  sectionsMap: PropTypes.shape({
    k0: PropTypes.arrayOf(PropTypes.number),
    k1: PropTypes.arrayOf(PropTypes.string)
  }),
  setSectionsMap: PropTypes.func,
};

SectionNameInput.propTypes = {
  name: PropTypes.string,
  updateName: PropTypes.func,
}

export default Section;
