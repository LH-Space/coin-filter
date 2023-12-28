<template>
    <div class="filter">
      <div class="filter-option">
        <label for="category">Category:</label>
        <select id="category">
          <option value="all">All</option>
          <option value="decentralized_finance">Decentralized Finance</option>
          <option value="stablecoins">Stablecoins</option>
        </select>
      </div>
      <button @click="applyFilters">Apply Filters</button>
    </div>
  </template>
  
  <script>
  export default {
    name: "Filter",
    methods: {
      applyFilters() {
        // Access the selected filter values
      const selectedCategory = document.getElementById("category").value;
      console.log("==============")
      // ... (get other filter values as needed)
      // Filter the currencies based on the selected criteria
      this.currencies = this.currencies.filter((currency) => {
        // Apply filtering logic here
        if (selectedCategory === "all") {
          return true;
        } else if (selectedCategory === "decentralized_finance") {
          return currency.category === "decentralized_finance";
        } else if (selectedCategory === "stablecoins") {
          return currency.category === "stablecoins";
        } else {
          return false;
        }
      });
    }
  }
};
</script>