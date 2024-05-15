import React, { useState, useEffect } from "react";
import Select from "react-select";

const SelectFilterComponent = ({ dataPath, onChange }) => {
  const [options, setOptions] = useState([]);

  useEffect(() => {
    fetch(dataPath)
      .then((response) => response.json())
      .then((data) => {
        const options = data.map((item) => ({
          value: item.id,
          label: item.name,
        }));
        setOptions(options);
      })
      .catch((error) => {
        console.error("Error fetching select data:", error);
      });
  }, []);

  return (
    <Select
      isMulti
      name="colors"
      options={options}
      className="form-control no-border-padding"
      classNamePrefix="select"
      dataPath={dataPath}
      onChange={onChange}
    />
  );
};

export default SelectFilterComponent;
