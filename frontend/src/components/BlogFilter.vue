<script setup>
const props = defineProps({
  filterCategory: String,
  filterCategoryItemsArray: Array,
  filterSelected: Array,
});

const emit = defineEmits(['update:filterSelected']);

const isChecked = (item) => {
  return props.filterSelected.includes(item);
};

const toggleItem = (item) => {
  const newFilterSelected = isChecked(item)
    ? props.filterSelected.filter((filterItem) => filterItem !== item)
    : [...props.filterSelected, item];
  emit('update:filterSelected', newFilterSelected);
};
</script>

<template>
  <details>
    <summary>
      {{ filterCategory }}:
      <template v-if="filterSelected && filterSelected.length">
        <span
          v-for="selectedItem in filterSelected"
          :key="selectedItem"
          class="mx-1 tag-test"
        >
          {{ selectedItem }}
        </span>
      </template>
      <span v-else>select {{ filterCategory }}</span>
    </summary>

    <ul>
      <li v-for="item in filterCategoryItemsArray" :key="item.name">
        <label>
          <input
            type="checkbox"
            :checked="isChecked(item.name)"
            @change="toggleItem(item.name)"
          />
          {{ item.name }}
        </label>
      </li>
    </ul>
  </details>
</template>
