<script setup>
import MENU_CONST from '@/constants/const.js';
import Career from '@/components/Career.vue';
import Feature from '@/components/Feature.vue';
</script>

<template>
    <div class="container mx-auto m-5 min-w-xs">
        <div class="">
            <div :id="MENU_CONST.ABOUT">
                <Career></Career>
                <Feature></Feature>
            </div>
            <div :id="MENU_CONST.CONTACT" class="m-1">
                <h3 class="text-2xl">Contact</h3>
                <div class="m-1">
                    <p class="">hogehoge@gmail.com</p>
                    <a
                        href="https://x.com/baretaco_rundev"
                        target="_blank"
                        rel="noopener noreferrer"
                        >X</a
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped></style>
