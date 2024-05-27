import { useBackend } from '../backend';
import { LabeledList } from '../components';
import { Window } from '../layouts';

export const RnDConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    level,
    budget,
    num_researched,
  } = data;
  return (
    <Window title="Research & Development v0.01 ALPHA">
      <Window.Content scrollable>
        <LabeledList>
          <LabeledList.Item label="Research Level">
            {level}
          </LabeledList.Item>
          <LabeledList.Item label="Research Budget">
            {budget}⪽
          </LabeledList.Item>
          <LabeledList.Item label="Projects Researched">
            {num_researched}
          </LabeledList.Item>
        </LabeledList>
      </Window.Content>
    </Window>
  );
};
