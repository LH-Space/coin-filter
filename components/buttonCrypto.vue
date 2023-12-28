<template>
   <div class="button-1">
      <button @click="showFilters = !showFilters">Filters</button>
    </div>
</template>

<script>
export default {
  name: "Button",
  data() {
    return {
      showFilters: false
    };
  },


};
</script>
